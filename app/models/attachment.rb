class Attachment < ActiveRecord::Base
  belongs_to :trip
  belongs_to :album
  belongs_to :user, foreign_key: "created_by"
  attr_accessible :attachment_type, :created_by, :description, :name, :url
end
