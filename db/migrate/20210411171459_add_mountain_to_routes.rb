class AddMountainToRoutes < ActiveRecord::Migration[6.0]
  def change
    add_reference :routes, :mountain, null: false, foreign_key: true
  end
end
