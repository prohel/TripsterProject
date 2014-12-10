class TripInvitesController < ApplicationController


  def create
    @trip_invites = TripInvite.new({
      sender: current_user,
      receiver: User.find(params[:receiver]),
      accepted: params[:accepted],
      trip: Trip.find(params[:trip_id])
    })
    if @trip_invites.save
      redirect_to(trips_path)
    end
  end

  def requestTrip
    trip = Trip.find(params[:trip_id])
    @trip_invites = TripInvite.new({
      sender: current_user,
      receiver: trip.user,
      accepted: params[:accepted],
      trip: trip
    })
    if @trip_invites.save
      redirect_to(trips_path())
      #redirect_to :controller => 'trip', :action => 'index'
    end
  end

  # def acceptRequest

  # end

  # def declineRequest

  # end
  
  def edit
    tripInvite = TripInvite.find(params[:id])
    tripInvite.accepted = params[:accepted]
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
