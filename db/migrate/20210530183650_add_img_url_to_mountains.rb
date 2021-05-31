class AddImgUrlToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :img_url, :text
  end
end
