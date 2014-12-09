class TripsController < ApplicationController
  before_filter :set_trip, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trips = Trip.all
    respond_with(@trips)
  end

  def show
    respond_with(@trip)
  end

  def new
    @trip = Trip.new
    respond_with(@trip)
  end

  def edit
  end

  def create
    @trip = Trip.new(params[:trip])
    @trip.save
    respond_with(@trip)
  end

  def update
    @trip.update_attributes(params[:trip])
    respond_with(@trip)
  end

  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end
end
