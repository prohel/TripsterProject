class UserLocation < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  # attr_accessible :title, :body
  attr_accessible :id, :user_id, :visited, :created_at, :updated_at, :location_id
end
