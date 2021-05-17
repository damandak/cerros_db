class CreateAndinistsClubs < ActiveRecord::Migration[6.0]
  def change
    create_table :andinists_clubs do |t|
    	t.belongs_to :andinist
    	t.belongs_to :club
    end
  end
end
