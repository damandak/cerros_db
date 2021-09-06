class AddSlugToSectors < ActiveRecord::Migration[6.0]
  def change
    add_column :sectors, :slug, :string
    add_index :sectors, :slug, unique: true
  end
end
