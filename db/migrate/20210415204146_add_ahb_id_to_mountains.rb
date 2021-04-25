class AddAhbIdToMountains < ActiveRecord::Migration[6.0]
  def change
    add_column :mountains, :ahb_id, :integer
  end
end
