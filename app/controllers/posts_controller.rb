class PostsController < ApplicationController
  I_PATH = File.join(Rails.root, "public", "i")
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
      

      redirect_to posts_path, notice: "The post #{@post.filename} has been uploaded."
    else
      render "new"
    end
  end

  def serve
    fp = File.join(I_PATH, params[:id])
    puts fp
    if File.exists? fp
      send_file fp
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private

  def post_params
    params.require(:post).permit(:comment, :attachment)
  end
end
