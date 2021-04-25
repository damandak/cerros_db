class CreateNomenclaturaObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :nomenclatura_objects do |t|
      t.string :nom_id
      t.string :revision_code
      t.string :name
      t.integer :altitude_igm
      t.string :latitude_south
      t.string :longitude_west
      t.string :observations
      t.string :comment

      t.timestamps
    end
  end
end
