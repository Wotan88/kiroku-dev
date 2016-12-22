//= require jquery

ongoingAjax = undefined
prevLength = 0
prevUpdateValue = ''
interval = null

autocompleteListSelector = undefined
fieldSelector = undefined
searchFormSelector = undefined

String::allTrim ||= ->
  this.replace(/\s+/g,' ').replace(/^\s+|\s+$/,'')

String::lastWord = ->
  a = this.split(' ')
  a[a.length - 1]

String::replaceLastWord = (r) ->
  arr = this.split(' ')
  words = if arr.length > 1 then (arr[i] for i in [0 ... arr.length - 1]) else []
  words.push r
  return words.join(' ')

String::hasWord = (r) ->
  $.inArray(r, this.split(' ')) != -1

addCompletion = (item) ->
  tag = document.createElement 'li'
  tag.appendChild document.createTextNode item.label

  tag.onclick = (ev) ->
    fieldSelector.val(fieldSelector.val().replaceLastWord(ev.target.innerHTML + ' '))
    fieldSelector.focus()
    autocompleteListSelector.css('display', 'none')

  autocompleteListSelector.append tag

loadCompletions = ->
  $.get '/api/complete.json', term: fieldSelector.val().lastWord(), (data) ->
    autocompleteListSelector.empty()
    addCompletion tag for tag in data.matches when not fieldSelector.val().hasWord(tag.label)
    autocompleteListSelector.css('display', 'block')

updateCompletions = (ignoreDelta = false) ->
  if ongoingAjax?
    ongoingAjax.abort()
    ongoingAjax = null

  if fieldSelector.val().lastWord().length >= 2 and (fieldSelector.val().length > prevLength or ignoreDelta)
    loadCompletions()
  else if fieldSelector.val().lastWord().length == 0
    autocompleteListSelector.empty()
    autocompleteListSelector.css('display', 'none')

  prevLength = fieldSelector.val().length

timedUpdateCompletions = ->
  if fieldSelector.val() isnt prevUpdateValue
    updateCompletions(true)
    prevUpdateValue = fieldSelector.val()

$(document).ready ->
  autocompleteListSelector = $('#autocomplete-items')
  fieldSelector = $('#autocomplete-field')
  searchFormSelector = $('#search-form')
  
  fieldSelector.on 'keydown', (ev) ->
    if ev.originalEvent.code == 'Tab'
      ev.preventDefault()

      if autocompleteListSelector.first()

        fieldSelector.val(fieldSelector.val().replaceLastWord(autocompleteListSelector[0].firstChild.innerText + ' '))
        fieldSelector.focus()
        autocompleteListSelector.css('display', 'none')

  fieldSelector.on 'input', (ev) ->
    if not interval?
      interval = setInterval(timedUpdateCompletions, 500)

    updateCompletions(false)

  fieldSelector.on 'focus', ->
    if autocompleteListSelector.first()
      autocompleteListSelector.css('display', 'block')

  fieldSelector.on 'blur', ->
    setTimeout(->
      autocompleteListSelector.css('display', 'none')
    , 100)

  searchFormSelector.on 'submit', (ev) ->
    ev.preventDefault()

    if not fieldSelector.val()? or fieldSelector.val().length == 0
      return false

    window.location.href = '/search?term=' + fieldSelector.val().allTrim().split(' ').join('+')
    return false