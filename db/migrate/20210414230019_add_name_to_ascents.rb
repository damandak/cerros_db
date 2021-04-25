class AddNameToAscents < ActiveRecord::Migration[6.0]
  def change
    add_column :ascents, :name, :string
  end
end
