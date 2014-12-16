class AlbumComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  attr_accessible :description, :user_id, :album_id
end
