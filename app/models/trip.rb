class Trip < ActiveRecord::Base
  #belongs_to  :created_by, :class_name => "User", :foreign_key => "created_by"
  attr_accessible :created_by, :end_date, :name, :start_date
  validate :date_validation
  validates :name, presence: true
  belongs_to :user, foreign_key: "created_by"
  acts_as_likeable
  has_many :members_invited, through: :trip_invites, foreign_key: "trip", source: "receiver", conditions: ["trip_invite.sender = ?, trip_invite.accepted = ?", :created_by, 1]
  has_many :members_accepted, through: :trip_invites, foreign_key: "trip", source: "sender", conditions: ["trip_invite.receiver = ?, trip_invite.accepted = ?", :created_by, 1]
  has_many :requests, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.receiver = ?", :created_by]
  has_many :invites, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.sender = ?", :created_by]
  has_many :pending_requests, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.receiver = ?, trip_invite.accepted = ?", :created_by, 2]
  has_many :pending_invites, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.sender = ?, trip_invite.accepted = ?", :created_by, 2]
  has_many :declined_requests, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.receiver = ?, trip_invite.accepted = ?", :created_by, 0]
  has_many :declined_invites, class_name: "TripInvite", foreign_key: "trip", conditions: ["trip_invite.sender = ?, trip_invite.accepted = ?", :created_by, 0]

  def members
  	members_invited + members_accepted
  end

  def date_validation
  	  p end_date
  	  p start_date
	  if end_date < start_date
	    errors[:end_date] << "End date should be after start_date"
	    return false
	  else
	    return true
	  end
  end

  def isMember(user)
 		requests = user.own_requests
    trip = requests.find(id) if !requests.blank?
 		!requests.blank? && !trip.blank? && trip.accepted == 1
  end

end

