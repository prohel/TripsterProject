class UserLocationsController < ApplicationController
  before_filter :set_user_location, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user = User.find(params[:user_id])
    @placesVisited = @user.user_locations.find_all_by_visited(1)
    @dreamlist = @user.user_locations.find_all_by_visited(0)
    respond_with(@placesVisited, @dreamlist)
  end

  def show
    respond_with(@user_location)
  end

  def new
    @user = User.find(params[:user_id])
    @visited = params[:visited]
    @user_location = UserLocation.new
    respond_with(@user, @user_location)
  end

  def edit
  end

  def create
    @user = User.find(params[:user_id])
    locationName = params[:user_location][:location]
    @location = Location.find_by_name(locationName)
    if @location.blank?
      @location = Location.new({
        name: locationName
        })
    end
    @user_location = UserLocation.new({
      user_id: @user.id,
      location_id: @location.id,
      visited: params[:visited]
      })
    @user_location.save
    @placesVisited = @user.user_locations.find_all_by_visited(1)
    @dreamlist = @user.user_locations.find_all_by_visited(0)
    render action: "index"
  end

  def update
    @user_location.update_attributes(params[:user_location])
    respond_with(@user_location)
  end

  def destroy
    @user = User.find(params[:user_id])
    @user_location.destroy
    respond_with(@user_location)
  end

  private
    def set_user_location
      @user_location = UserLocation.find(params[:id])
    end
end
