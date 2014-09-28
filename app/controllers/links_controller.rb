class LinksController < ApplicationController

  load_and_authorize_resource

  def index
    @links = Link.all
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

  private
    def link_params
      params.require(:link).permit(:title,
                                   :url,
                                   :reason)
    end

end
