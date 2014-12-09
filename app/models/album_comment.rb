class AlbumComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :album
  attr_accessible :description
end
