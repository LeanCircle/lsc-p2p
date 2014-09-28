class PostsController < ApplicationController

  load_and_authorize_resource

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    redirect_to posts_path if params[:commit].eql?('Cancel')
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.try(:save)
      flash[:success] = "Your post still needs to be approved. A human will check it shortly!"
      redirect_to posts_path
    else
      render :action => "new"
    end
  end

  private
    def post_params
      params.require(:post).permit(:title,
                                    :url)
    end

end
