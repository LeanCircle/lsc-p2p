class GroupsController < ApplicationController

  def index
    @groups = Group.approved
  end

end