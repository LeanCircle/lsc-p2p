class LinksController < ApplicationController

  load_and_authorize_resource

  def index
    @links = Link.all.order(:created_at => :desc)
    set_unvoted
  end

  def show
    @link = Link.find(params[:id])
    render layout: 'link'
  end

  def new
    @link = Link.new
  end

  def create
    redirect_to links_path and return if params[:commit].eql?('Cancel')
    @link = Link.new(link_params)
    @link.user_id = current_user.id
    if @link.try(:save)
      @link.liked_by current_user
      flash[:success] = "Success! Your link was posted."
      redirect_to links_path
    else
      render :action => "new"
    end
  end

  def upvote
    @link = Link.find(params[:link_id])
    @link.liked_by current_user
    redirect_to redirect_url_after_voting
    end
  end

  def downvote
    @link = Link.find(params[:link_id])
    @link.disliked_by current_user
    redirect_to redirect_url_after_voting
  end

  private
    def link_params
      params.require(:link).permit(:title,
                                   :url,
                                   :reason)
    end

    def set_unvoted
      if current_user
        seen = current_user.votes.votables
        @unvoted = (Link.all.order(:created_at => :desc) - seen)
      end
    end

    def redirect_url_after_voting
      puts "referrer: " + URI(request.referer).path.to_s
      puts "links_path: " + links_path.to_s
      if current_user && (!request.referer.present? || URI(request.referer).path == links_path)
        return links_path
      else
        set_unvoted
        return link_path(@unvoted.first)
    end
end