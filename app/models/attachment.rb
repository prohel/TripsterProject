class Attachment < ActiveRecord::Base
  belongs_to :trip
  belongs_to :album
  belongs_to :user, foreign_key: "created_by"
  has_many :attachment_comments
  acts_as_likeable
  attr_accessible :attachment_type, :created_by, :description, :name, :url, :trip_id, :album_id
  ATTACHMENT_TYPES = ["photo", "link", "note", "video"]
end
