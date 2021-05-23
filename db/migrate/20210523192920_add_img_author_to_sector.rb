class AddImgAuthorToSector < ActiveRecord::Migration[6.0]
  def change
    add_column :sectors, :img_author, :string
  end
end
