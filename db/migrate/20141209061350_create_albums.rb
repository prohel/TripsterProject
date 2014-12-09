class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :trip
      t.string :name
      t.integer :created_by

      t.timestamps
    end
    add_index :albums, :trip_id
  end
end
