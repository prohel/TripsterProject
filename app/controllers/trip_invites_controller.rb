class TripsInvitesController < ApplicationController


  def create
    @trips_invites = TripInvite.new({
      sender: current_user,
      receiver: params[:receiver],
      accepter: params[:accepted],
      trip_id: params[:trip_id]
    })
    if @trips_invites.save
      redirect_to(trips_path)
    end
  end

  def requestTrip
    trip = Trip.find(params[:trip_id])
    @trips_invites = TripInvite.new({
      sender: current_user,
      receiver: trip.created_by,
      accepter: params[:accepted],
      trip_id: params[:trip_id]
    })
    if @trips_invites.save
      redirect_to(trips_path())
      #redirect_to :controller => 'trip', :action => 'index'
    end
  end

  # def acceptRequest

  # end

  # def declineRequest

  # end
  
  def edit
    sender = params[:sender]
    receiver = params[:receiver]
    trip_id = params[:tripid]
    tripInvite = TripInvite.find_by_sender_and_receiver_and_trip_id(sender, receiver, trip_id)
    accepted = params[:accepted]
    tripInvite.accepted = accepted
    tripInvite.save
    redirect_to(trips_path())
  end


  # def hasJoiningTripBeenRequested(receiverEmail, tripId)
  # #   flag = 0
  # #   if(flag)
  # #     flag = 0
  # #     return 1
  # #   else
  # #     flag = 1
  # #     return 0
  #    return !TripInvite.find_by_sender_and_receiver_and_trip_id(current_user.email, receiverEmail, tripId).blank?
  # end

 # private
    
 #    # Never trust parameters from the scary internet, only allow the white list through.
 #    def trips_invites_params
 #      params.require(:trips_invites).permit(:sender, :receiver, :accepted, :trip_id)
 #    end
end
