class Route < ApplicationRecord
	belongs_to :mountain
	has_many :ascents
	has_many :sources, as: :referenceable
	after_update :update_badges
	after_create :update_badges

	has_paper_trail

	def first_ascent
		if self.unregistered_sport_ascent then
			return nil
		end
		return self.ascents.sort_by(&:fulldate).first
	end

	def first_winter_ascent
		if self.unregistered_sport_ascent then
			return nil
		end
		winter_ascents = self.ascents.where('month = 7')
		winter_ascents += self.ascents.where('month = 8')
		winter_ascents += self.ascents.where('month = 6').where('day > 20')
		winter_ascents += self.ascents.where('month = 9').where('day < 22')
		return winter_ascents.sort_by(&:fulldate).first
	end

	def first_ascent_fulldate
		if self.unregistered_sport_ascent then
			return "9999"
		end
		return self.first_ascent ? self.first_ascent.fulldate : "9999"
	end

	def update_badges
  		mountain = self.mountain
	  	
	    mountain.ascents.each do |ascent|
			if not self.unregistered_sport_ascent and self.ascents.sort_by(&:fulldate).first == ascent then
				ascent.update_column(:first_ascent, true)
				if not mountain.unregistered_sport_ascent and mountain.ascents.sort_by(&:fulldate).first == ascent then
			  		ascent.update_column(:first_absolute, true)
				end
			end
			ascent.andinists.each do |andinist|
			  andinist.update_column(:remarkable_ascents, andinist.ascents.count)
			  andinist.update_column(:first_absolutes, andinist.ascents.where(:first_absolute => true).count)
			  andinist.update_column(:first_ascents, andinist.ascents.where(:first_ascent => true).count)
			end
	    end
	    andinists = []
	    self.ascents.each do |ascent|
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
