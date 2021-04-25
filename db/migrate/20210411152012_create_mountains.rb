class CreateMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains do |t|
      t.string :name
      t.string :prefix
      t.integer :altitude
      t.string :latitude
      t.string :longitude
      t.string :nom_id

      t.timestamps
    end
  end
end
