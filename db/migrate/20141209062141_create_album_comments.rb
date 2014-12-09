class CreateAlbumComments < ActiveRecord::Migration
  def change
    create_table :album_comments do |t|
      t.references :user
      t.references :album
      t.text :description

      t.timestamps
    end
    add_index :album_comments, :user_id
    add_index :album_comments, :album_id
  end
end
