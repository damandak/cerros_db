class AddClubToSAndCountryToSToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :club_to_s, :string
    add_column :andinists, :country_to_s, :string

    Andinist.all.each do |andinist|
      countries = []
      andinist.countries.order("name").each do |country|
        countries << country.name
      end

      clubs = []
      andinist.clubs.order("name").each do |club|
        clubs << club.name
      end

      andinist.update_column(:country_to_s, countries.join(" - "))
      andinist.update_column(:club_to_s, clubs.join(" - "))
    end
  end
end
