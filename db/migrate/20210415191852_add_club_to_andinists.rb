class AddClubToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :club, :string
  end
end
