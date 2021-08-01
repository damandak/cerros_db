class AddStatsToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :remarkable_ascents, :integer
    add_column :andinists, :first_absolutes, :integer
    add_column :andinists, :first_ascents, :integer
  end
end
