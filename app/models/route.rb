class Route < ApplicationRecord
	belongs_to :mountain
	has_many :ascents

	def first_ascent
		return self.ascents.sort_by(&:fulldate).first
	end

	def first_ascent_fulldate
		return self.first_ascent ? self.first_ascent.fulldate : "9999"
	end
end
