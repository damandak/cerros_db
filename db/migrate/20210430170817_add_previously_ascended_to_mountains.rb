class AddPreviouslyAscendedToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :previously_ascended, :boolean
  end
end
