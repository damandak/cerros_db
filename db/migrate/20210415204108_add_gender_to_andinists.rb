class AddGenderToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :gender, :string
  end
end
