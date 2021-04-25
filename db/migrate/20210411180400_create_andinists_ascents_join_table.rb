class CreateAndinistsAscentsJoinTable < ActiveRecord::Migration[6.0]
  def change
	create_join_table :andinists, :ascents do |t|
		t.index :andinist_id
		t.index :ascent_id
	end
  end
end
