class CreateIgmMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :igm_maps do |t|
      t.string :name
      t.string :filecode

      t.timestamps
    end
  end
end
