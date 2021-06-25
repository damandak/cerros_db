class Country < ApplicationRecord
	has_and_belongs_to_many :mountains
	has_and_belongs_to_many :andinists

	has_paper_trail

	scope :with_mountains, -> {
    	self.joins(:mountains).distinct
  	}
end
