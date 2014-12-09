class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :attachment_type
      t.references :trip
      t.references :album
      t.integer :created_by
      t.string :url
      t.string :description

      t.timestamps
    end
    add_index :attachments, :trip_id
    add_index :attachments, :album_id
  end
end
