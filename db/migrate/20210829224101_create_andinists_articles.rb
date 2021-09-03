class CreateAndinistsArticles < ActiveRecord::Migration[6.0]
  def change
    create_join_table :andinists, :articles do |t|
      t.index :andinist_id
      t.index :article_id
    end
  end
end
