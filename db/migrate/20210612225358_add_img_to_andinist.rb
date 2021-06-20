class AddImgToAndinist < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :img_url, :text
    add_column :andinists, :img_author, :string
  end
end
