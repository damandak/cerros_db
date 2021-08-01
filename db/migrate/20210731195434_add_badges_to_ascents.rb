class AddBadgesToAscents < ActiveRecord::Migration[6.0]
  def change
    add_column :ascents, :first_absolute, :boolean
    add_column :ascents, :first_ascent, :boolean

    
  end
end
