class CreateCountriesAndAndinists < ActiveRecord::Migration[6.0]
  def change
    create_table :andinists_countries do |t|
    	t.belongs_to :country
    	t.belongs_to :andinist
    end
  end
end
