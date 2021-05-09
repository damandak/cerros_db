class Route < ApplicationRecord
	belongs_to :mountain
	has_many :ascents

	def first_ascent
		return self.ascents.sort_by(&:fulldate).first
	end

	def first_winter_ascent
		winter_ascents = self.ascents.where('month = 7')
		winter_ascents += self.ascents.where('month = 8')
		winter_ascents += self.ascents.where('month = 6').where('day > 20')
		winter_ascents += self.ascents.where('month = 9').where('day < 22')
		return winter_ascents.sort_by(&:fulldate).first
	end

	def first_ascent_fulldate
		return self.first_ascent ? self.first_ascent.fulldate : "9999"
	end
end
