class Album < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user, foreign_key: "created_by"
  has_many :album_comments
  acts_as_likeable
  attr_accessible :created_by, :name, :trip_id, :privacy
  acts_as_likeable
end
