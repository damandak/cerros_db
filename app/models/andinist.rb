class Andinist < ApplicationRecord
  has_and_belongs_to_many :ascents
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :clubs
  has_many :sources, as: :referenceable

  has_paper_trail
  
  attr_accessor :first_club, :second_club, :third_club
  attr_accessor :first_country, :second_country, :third_country


  def fullname
    return [self.name,self.surname].join(" ")
  end
end
