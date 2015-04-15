class GroupsController < ApplicationController
  before_filter :location_setup

  @location = nil

  def index
    @groups = Group.nearest(@location).approved.active
    @gmaps_hash = []
    @groups.each do |group|
      @gmaps_hash << { lat: group.latitude, lng: group.longitude }
    end
  end

  def new
    @group = Group.new
  end

  def create
    redirect_to groups_path if params[:commit].eql?('Cancel')
    @group = Group.new(post_params)
    if @group.try(:save)
      UserMailer.group_application(@group).deliver
      flash[:success] = "Your group still needs to be approved. A human will check it shortly!"
      redirect_to groups_path
    else
      render :action => "new"
    end
  end

  private

  def location_setup
    return unless @location.blank?
    Rails.env.development? ? @location = Geocoder.search("Boston").first : @location = request.location
  end

  def post_params
    params.require(:group).permit(:name,
                                  :city,
                                  :province,
                                  :country,
                                  :meetup_link,
                                  :facebook_link,
                                  :googleplus_link,
                                  :linkedin_link,
                                  :twitter_link,
                                  :other_link)
  end

end