class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user1
      t.references :user2

      t.timestamps
    end
    add_index :friendships, :user1_id
    add_index :friendships, :user2_id
  end
end
