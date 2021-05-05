class AddAhbToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :ahb, :string
  end
end
