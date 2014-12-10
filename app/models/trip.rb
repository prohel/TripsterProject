class Trip < ActiveRecord::Base
  #belongs_to  :created_by, :class_name => "User", :foreign_key => "created_by"
  attr_accessible :created_by, :end_date, :name, :start_date
  validate :date_validation
  validates :name, presence: true
  belongs_to :user, foreign_key: "created_by"
  acts_as_likeable
  has_many :trip_invites
  

  def members
  	invited_members + accepted_members
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
    accepted_members.include?(user) or
      invited_members.include?(user)
  end

  def invited_members
    TripInvite.where("sender = ? AND trip_invites.accepted = 1", created_by).map(&:receiver)
  end

  def accepted_members
    TripInvite.where("receiver = ? AND trip_invites.accepted = 1", created_by).map(&:sender)
  end

  def requests
    TripInvite.where("receiver = ?", created_by)
  end
  
  def invites
    TripInvite.where("sender = ?", created_by)
  end

  def pending_requests
    TripInvite.where("receiver = ? AND accepter = 2", created_by)
  end

  def pending_invites
    TripInvite.where("sender = ? AND accepter = 2", created_by)
  end

  def declined_requests
    TripInvite.where("receiver = ? AND accepter = 0", created_by)
  end

  def declined_invites
    TripInvite.where("sender = ? AND accepter = 0", created_by)
  end

end

