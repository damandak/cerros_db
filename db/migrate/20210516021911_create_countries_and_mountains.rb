class CreateCountriesAndMountains < ActiveRecord::Migration[6.0]
  def change
    create_table :countries_mountains do |t|
    	t.belongs_to :country
    	t.belongs_to :mountain
    end
  end
end
