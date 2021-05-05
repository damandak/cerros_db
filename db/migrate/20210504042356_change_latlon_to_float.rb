class ChangeLatlonToFloat < ActiveRecord::Migration[6.0]
	remove_column :mountains, :latitude
	remove_column :mountains, :longitude
  add_column :mountains, :latitude, :float, {:precision=>10, :scale=>6}
  add_column :mountains, :longitude, :float, {:precision=>10, :scale=>6}
end
