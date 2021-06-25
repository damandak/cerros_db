class IgmRectangle < ApplicationRecord
	has_many :nomenclatura_objects

	has_paper_trail
end
