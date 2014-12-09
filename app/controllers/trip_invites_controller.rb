class TripInvitesController < ApplicationController
  before_filter :set_trip_invite, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trip_invites = TripInvite.all
    respond_with(@trip_invites)
  end

  def show
    respond_with(@trip_invite)
  end

  def new
    @trip_invite = TripInvite.new
    respond_with(@trip_invite)
  end

  def edit
  end

  def create
    @trip_invite = TripInvite.new(params[:trip_invite])
    @trip_invite.save
    respond_with(@trip_invite)
  end

  def update
    @trip_invite.update_attributes(params[:trip_invite])
    respond_with(@trip_invite)
  end

  def destroy
    @trip_invite.destroy
    respond_with(@trip_invite)
  end

  private
    def set_trip_invite
      @trip_invite = TripInvite.find(params[:id])
    end
end
