class DropInstalls < ActiveRecord::Migration[6.0]
  def change
  	drop_table :references
  	drop_table :igm_maps
  end
end
