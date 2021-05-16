class Country < ApplicationRecord
	has_and_belongs_to_many :mountains
	has_and_belongs_to_many :andinists

	scope :with_mountains, -> {
    	self.joins(:mountains).distinct
  	}
end
