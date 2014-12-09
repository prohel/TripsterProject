class Friendship < ActiveRecord::Base
	has_one :user1, class_name: "User"
	has_one :user2, class_name: "User"

	def isReciprocate
 		!Friendship.find_by_user1_id_and_user2_id(
 			self.user2_id, self.user1_id).blank?
 	end

 	def reciprocate
 		Friendship.find_by_user1_id_and_user2_id(
 			self.user2_id, self.user1_id)
 	end

 	def user1
 		User.find(self.user1_id)
 	end

 	def user2
 		User.find(self.user2_id)
 	end
end
