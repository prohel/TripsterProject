class Attachment < ActiveRecord::Base
  belongs_to :trip
  belongs_to :album
  belongs_to :user, foreign_key: "created_by"
  has_many :attachment_comments
  acts_as_likeable
  attr_accessible :attachment_type, :created_by, :description, :name, :url, :trip_id, :album_id, :privacy
  ATTACHMENT_TYPES = ["photo", "link", "note", "video"]

  def like(user)
  	user.like!(self)
  end

  acts_as_likeable
end
