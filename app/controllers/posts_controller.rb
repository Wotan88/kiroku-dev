class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params) do |t|
      if params[:post][:data]
        t.attachment = params[:post][:data].read
        t.filename = params[:post][:data].original_filename
        # TODO
        t.mime = 1
      end
    end

    if @post.save
      redirect_to(@post, :notice => 'Post was created')
    else
      render :action => "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:comment, :post)
  end
end
