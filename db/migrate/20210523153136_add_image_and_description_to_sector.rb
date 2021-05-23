class AddImageAndDescriptionToSector < ActiveRecord::Migration[6.0]
  def change
    add_column :sectors, :img_url, :text
    add_column :sectors, :description, :string
  end
end
