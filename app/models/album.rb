class Album < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user, foreign_key: "created_by"
  attr_accessible :created_by, :name
end
