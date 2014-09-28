class LinksController < ApplicationController

  load_and_authorize_resource

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    redirect_to posts_path if params[:commit].eql?('Cancel')
    @link = Link.new(post_params)
    @link.user_id = current_user.id
    if @link.try(:save)
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
