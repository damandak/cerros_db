class CreateSectors < ActiveRecord::Migration[6.0]
  def change
    create_table :sectors do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
