class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
      
    if @post.save
      # Full path to file is stored in @post.attachment.current_path
      # TODO: Here will be code for thumbnail generation

      redirect_to posts_path, notice: "The post #{@post.filename} has been uploaded."
    else
      render "new"
    end
  end

  def serve
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:comment, :attachment)
  end
end
