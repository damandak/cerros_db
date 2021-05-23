class CreateMountainsAndSectors < ActiveRecord::Migration[6.0]
  def change
    create_table :mountains_sectors do |t|
    	t.belongs_to :mountain
    	t.belongs_to :sector
    end
  end
end
