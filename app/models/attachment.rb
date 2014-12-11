class Attachment < ActiveRecord::Base
  belongs_to :trip
  belongs_to :album
  belongs_to :user, foreign_key: "created_by"
  attr_accessible :attachment_type, :created_by, :description, :name, :url, :trip_id, :album_id
  ATTACHMENT_TYPES = ["Image", "Link", "Note"]
end
