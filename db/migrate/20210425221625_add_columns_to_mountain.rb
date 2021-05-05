class AddColumnsToMountain < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :alternative_name_prefix, :string
    add_column :mountains, :alternative_name, :string
    add_column :mountains, :secondary_altitude, :integer
    add_column :mountains, :secondary_altitude_name, :string
  end
end
