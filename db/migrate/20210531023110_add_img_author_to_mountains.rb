class AddImgAuthorToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :img_author, :string
  end
end
