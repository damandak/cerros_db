class Andinist < ApplicationRecord
  has_and_belongs_to_many :ascents
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :clubs


  def fullname
    return [self.name,self.surname].join(" ")
  end
end
