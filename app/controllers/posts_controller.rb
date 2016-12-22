class PostsController < ApplicationController
  I_PATH = File.join(Rails.root, "public", "i")
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.paginate(:page => params[:page]).order('id desc')

    if request.xhr?
      render :partial => "post"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    ps = post_params
    ps[:tags] = ps[:tags].split.uniq.to_json
    @post = Post.new(ps)
      
    if @post.save
      redirect_to new_post_path, notice: "The post #{@post.id} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    if current_user.admin?
      @post = Post.find(params[:id])
      @post.destroy
    end

    redirect_to posts_path
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
    params.require(:post).permit(:comment, :attachment, :tags)
  end
end
