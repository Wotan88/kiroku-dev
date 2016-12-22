//= require jquery

autocompleteListSelector = undefined

String::lastWord = ->
  this.split(' ')[..-1]

String::replaceLastWord = (r) ->
  arr = this.split(' ')
  words = (word for word in arr.split())[-1..]
  words.push r
  return words.join ' '


loadCompletions = ->
  $.get '/api/complete.json', term: 'test', (data) ->
    autocompleteListSelector.css('display', 'block')
    console.log(autocompleteListSelector)

$(document).ready ->
  autocompleteListSelector = $('#autocomplete-items')
  loadCompletions()