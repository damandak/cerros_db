class AddRouteToAscent < ActiveRecord::Migration[6.0]
  def change
    add_reference :ascents, :route, null: false, foreign_key: true
  end
end
