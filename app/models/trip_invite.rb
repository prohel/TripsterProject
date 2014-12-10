class TripInvite < ActiveRecord::Base
  attr_accessible :accepted, :receiver, :sender, :trip
  belongs_to :trip
  belongs_to :sender, class_name: "User", foreign_key: "sender"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver"

  def status
    return "Accepted" if accepted == 1
    return "Pending" if accepted == 2
    return "Declined"
  end

end
