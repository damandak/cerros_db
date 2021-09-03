class AddCoverToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :img_url, :string
    add_column :articles, :img_author, :string
  end
end
