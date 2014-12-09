class UserLocationsController < ApplicationController
  before_filter :set_user_location, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user_locations = UserLocation.all
    respond_with(@user_locations)
  end

  def show
    respond_with(@user_location)
  end

  def new
    @user_location = UserLocation.new
    respond_with(@user_location)
  end

  def edit
  end

  def create
    @user_location = UserLocation.new(params[:user_location])
    @user_location.save
    respond_with(@user_location)
  end

  def update
    @user_location.update_attributes(params[:user_location])
    respond_with(@user_location)
  end

  def destroy
    @user_location.destroy
    respond_with(@user_location)
  end

  private
    def set_user_location
      @user_location = UserLocation.find(params[:id])
    end
end
