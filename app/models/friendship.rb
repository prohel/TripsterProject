class Friendship < ActiveRecord::Base
  has_one :user1, class_name: "User"
  has_one :user2, class_name: "User"
  # attr_accessible :title, :body
end
