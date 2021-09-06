class AddSlugToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :slug, :string
    add_index :mountains, :slug, unique: true
  end
end
