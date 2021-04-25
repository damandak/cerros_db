class AddIgmRectanglesToNomenclaturaObjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :nomenclatura_objects, :igm_rectangle, null: false, foreign_key: true
  end
end
