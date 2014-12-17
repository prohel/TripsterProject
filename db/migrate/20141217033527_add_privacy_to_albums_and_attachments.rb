class AddPrivacyToAlbumsAndAttachments < ActiveRecord::Migration
  def change
    add_column :albums, :privacy, :integer
    add_column :attachments, :privacy, :integer
  end
end
