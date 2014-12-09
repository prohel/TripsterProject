class CreateTripInvites < ActiveRecord::Migration
  def change
    create_table :trip_invites do |t|
      t.references :trip
      t.integer :sender
      t.integer :receiver
      t.integer :accepted

      t.timestamps
    end
  end
end
