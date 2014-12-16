class AttachmentComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachment
  attr_accessible :description, :user_id, :attachment_id
end
