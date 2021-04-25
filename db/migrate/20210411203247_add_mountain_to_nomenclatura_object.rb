class AddMountainToNomenclaturaObject < ActiveRecord::Migration[6.0]
  def change
    add_reference :nomenclatura_objects, :mountain, null: false, foreign_key: true
  end
end
