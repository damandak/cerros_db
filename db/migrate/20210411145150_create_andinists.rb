class CreateAndinists < ActiveRecord::Migration[6.0]
  def change
    create_table :andinists do |t|
      t.string :name
      t.string :surname
      t.string :country

      t.timestamps
    end
  end
end
