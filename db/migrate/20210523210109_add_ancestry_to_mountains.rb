class AddAncestryToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :ancestry, :string
  end

  def up
  	add_index :mountains, :ancestry
  end

  def down
  	remove_index :mountains, :ancestry
  end
end
