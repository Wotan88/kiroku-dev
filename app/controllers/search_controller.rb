class SearchController < ApplicationController
  def by_tags
    tags = params[:term].split(' ')
    if tags.empty?
      return
    end

    regex_query = ''
    for tag in tags do
      regex_query += "(?=.*#{tag})"
    end

    @term = tags.join ' '
    @posts = Post.where(['tags ~* ?', regex_query]).paginate(:page => params[:page]).order('id desc')

    if request.xhr?
      render :partial => "post"
    end
  end
end
