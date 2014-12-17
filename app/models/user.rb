class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  validates_presence_of :name
  attr_accessible :email, :password, :name, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :album_comments
  has_many :attachment_comments
  has_many :user_locations
  has_many :trips, :foreign_key => "created_by"
  has_many :albums, :foreign_key => "created_by"
  has_many :attachments, :foreign_key => "created_by"
  has_many :trip_invites, :foreign_key => "sender", as: :sender
  has_many :trip_requests, class_name: "TripInvite", :foreign_key => "receiver", as: :receiver
  has_many  :trips_joined, :through => :trip_invites, 
          :class_name => "Trip", 
          :source => :trip,
          :foreign_key => "receiver",
          :conditions => ['trip_invites.accepted = ?',1]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def hasFriendshipBeenRequested(target)
    return !Friendship.find_by_user1_id_and_user2_id(self.id, target.id).blank?
  end

  def isFriendWith(user)
    !Friendship.find_by_user1_id_and_user2_id(id, user.id).blank? and
      !Friendship.find_by_user1_id_and_user2_id(user.id, id).blank?
  end

  def friends
    result = []
    friendships_request = Friendship.where("user1_id = ?", self.id)
    friendships_request.each do |fr|
      result << fr.user2_id if fr.isReciprocate
    end
    User.find(result)
  end

  def friendships
    result = []
    friendships_request = Friendship.where("user1_id = ?", self.id)
    friendships_request.each do |fr|
      r = fr.reciprocate
      if r
        if fr.created_at >= r.created_at
          result << fr
        else
          result << r
        end
      end
    end
  end

  def own_requests
    TripInvite.joins(:trip).where("trip_invites.sender = ? AND trip_invites.receiver = trips.created_by", id)
  end

  def others_requests
    TripInvite.joins(:trip).where("trip_invites.receiver = ? AND trips.created_by = ?", id, id)
  end

  def own_invites
    TripInvite.joins(:trip).where("trip_invites.sender = ? AND trips.created_by = ?", id, id)
  end

  def others_invites
    TripInvite.joins(:trip).where("receiver = ? AND sender = trips.created_by", id)
  end

  def accepted_requests_and_invites
    TripInvite.where("(receiver = ? OR sender = ?) AND accepted = 1", id, id)
  end

  def photo
    !image.blank? ? image : "/assets/silhouette.png"
  end

  def public_attachments
    Attachment.find_all_by_created_by_and_privacy(id, 0)
  end

  def public_albums
    Album.find_all_by_created_by_and_privacy(id, 0)
  end

 acts_as_liker

end
