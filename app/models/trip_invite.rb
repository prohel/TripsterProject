class TripInvite < ActiveRecord::Base
  attr_accessible :accepted, :receiver, :sender, :trip
end
