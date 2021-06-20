class AddUnregisteredAscentsToMountain < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :unregistered_non_sport_ascent, :boolean
    add_column :mountains, :unregistered_sport_ascent, :boolean
  end
end
