class Andinist < ApplicationRecord
  has_and_belongs_to_many :ascents
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :clubs

  attr_accessor :first_club, :second_club, :third_club


  def fullname
    return [self.name,self.surname].join(" ")
  end
end
