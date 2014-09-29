class LinksController < ApplicationController

  load_and_authorize_resource

  def index
    @links = Link.order(:cached_weighted_score => :desc)
  end

  def new
    @link = Link.new
  end

  def create
    redirect_to links_path if params[:commit].eql?('Cancel')
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.try(:save)
      flash[:success] = "Success! Your link was posted."
      redirect_to links_path
    else
      render :action => "new"
    end
  end

  def upvote
    authorize! :upvote, :links
    @link = Link.find(params[:link_id])
    @link.liked_by current_user
    redirect_to :back
  end

  def downvote
    @link = Link.find(params[:link_id])
    @link.disliked_by current_user
    redirect_to :back
  end


  private
    def link_params
      params.require(:link).permit(:title,
                                   :url,
                                   :reason)
    end

end
