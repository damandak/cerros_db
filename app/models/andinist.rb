class Andinist < ApplicationRecord
  include ActiveModel::Dirty
  has_and_belongs_to_many :ascents
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :clubs
  has_many :sources, as: :referenceable
  after_update :update_fullname, :update_country_to_s, :update_club_to_s, :update_ascent_info
  after_create :update_fullname, :update_country_to_s, :update_club_to_s, :update_ascent_info

  has_paper_trail
  
  attr_accessor :first_club, :second_club, :third_club
  attr_accessor :first_country, :second_country, :third_country

  
  private

  def update_fullname
    self.update_column(:fullname, [self.name,self.surname].join(" "))
  end

  def update_country_to_s
    countries = []
    self.countries.order("name").each do |country|
      countries << country.name
    end
    self.update_column(:country_to_s, countries.join(" - "))
  end

  def update_club_to_s
    clubs = []
    self.clubs.order("name").each do |club|
      clubs << club.name
    end
    self.update_column(:club_to_s, clubs.join(" - "))
  end

  def update_ascent_info
    self.ascents.each do |ascent|
      andinists = []
      ascent.andinists.each do |andinist|
        andinists << andinist.fullname
      end
      ascent.update_column(:mountain_name, ascent.route.mountain.fullname)
      ascent.update_column(:route_name, ascent.route.name)
      ascent.update_column(:andinists_to_s, andinists.join(', '))
      ascent.update_fulldate
      ascent.update_fulldate_for_form
    end
  end

end
