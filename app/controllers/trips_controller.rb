class TripsController < ApplicationController
  before_filter :set_trip, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @user = current_user
    @userTrips = current_user.trips
    @friends = current_user.friends                                              
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @creator = User.find(@trip.created_by)
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # GET /trips/1/invite
  def invite
    #respond to do |format|
    @trip = Trip.find(params[:trip])
    @creator = User.find(@trip.created_by)
    members = @trip.members.map(&:id)
    @list = @creator.friends.delete_if {|friend| members.include?(friend.id)}                
  end

  # def requestTrips
  # end


  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(params[:trip])
    @trip.created_by = current_user.id
    @trip.start_date = Date.parse params[:trip][:start_date]
    @trip.end_date = Date.parse params[:trip][:end_date]
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update_attributes({
        name: params[:trip][:name],
        start_date: (Date.parse params[:trip][:start_date]),
        end_date: (Date.parse params[:trip][:end_date]),
        created_by: current_user.id
        })
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def showTripNotifications
    #requests I am sending to other people to join their trips
    @myRequestsToJoinTrip = current_user.own_requests

    #invites sent to other people for my trips
    @friendsInvitedToTrip = current_user.own_invites   

    #other people requesting to join my trips
    @requestsToJoinMyTrip = current_user.others_requests

    #other people are sending me invites to join their trip
    @requestsToJoinFriendsTrip = current_user.others_invites
  end

  # def hasJoiningTripBeenRequested(receiverEmail, tripId)
  #   return !TripInvite.find_by_sender_email_and_receiver_email_and_trip_id(self.email, receiverEmail, tripId).blank?
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name, :id, :start_date, :end_date)
    end

    # Set created_by
   # def set_created_by
    #  @trip = Trip.find(params[:id])
     # @trip[:created_by] = "sandesh"
    #end
end