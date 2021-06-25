class Sector < ApplicationRecord
	has_and_belongs_to_many :mountains

	has_paper_trail
end
