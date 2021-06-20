class AddUnregisteredAscentsToRoute < ActiveRecord::Migration[6.0]
  def change
    add_column :routes, :unregistered_non_sport_ascent, :boolean
    add_column :routes, :unregistered_sport_ascent, :boolean
  end
end
