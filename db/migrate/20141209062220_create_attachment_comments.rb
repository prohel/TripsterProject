class CreateAttachmentComments < ActiveRecord::Migration
  def change
    create_table :attachment_comments do |t|
      t.references :user
      t.references :attachment
      t.text :description

      t.timestamps
    end
    add_index :attachment_comments, :user_id
    add_index :attachment_comments, :attachment_id
  end
end
