class AddSlugToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :slug, :string
    add_index :andinists, :slug, unique: true
  end
end
