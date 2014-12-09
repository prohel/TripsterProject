class TripInvite < ActiveRecord::Base
  attr_accessible :accepted, :receiver, :sender, :trip
  belongs_to :trip
end
