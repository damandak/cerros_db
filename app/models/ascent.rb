class Ascent < ApplicationRecord
	belongs_to :route
	has_and_belongs_to_many :andinists
	has_many :sources, as: :referenceable
	after_update :update_fulldate, :update_badges
	after_create :update_fulldate, :update_badges
	
	has_paper_trail
	
	attr_accessor :ascent_date, :no_month, :no_day

	def update_fulldate
		day = (self.day and self.day < 10) ? "0" + self.day.to_s : self.day.to_s
		month = (self.month and self.month < 10) ? "0" + self.month.to_s : self.month.to_s
		date_string = self.year.to_s + "-"
		date_string += self.month ? month.to_s + "-" : "xx-"
		date_string += self.day ? day.to_s : "xx"

		self.update_column(:fulldate, date_string)
  	end

  	def update_fulldate_for_form
  		day = (self.day and self.day < 10) ? "0" + self.day.to_s : self.day.to_s
		month = (self.month and self.month < 10) ? "0" + self.month.to_s : self.month.to_s
		date_string = self.year.to_s + "-"
		date_string += self.month ? month.to_s + "-" : "01-"
		date_string += self.day ? day.to_s : "01"

    	self.update_column(:fulldate_for_form, date_string)
  	end

  	private

  	def update_badges
  		route = self.route
  		mountain = route.mountain
	  	
	  	if mountain.ascents.count > 0 or mountain.unregistered_sport_ascent then
	      self.previously_ascended = true
	    else
	      self.previously_ascended = false
	    end

	    mountain.ascents.each do |ascent|
			if not route.unregistered_sport_ascent and route.ascents.sort_by(&:fulldate).first == ascent then
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
		self.andinists.each do |andinist|
			andinists << andinist.fullname
		end

		self.update_column(:mountain_name, self.route.mountain.fullname)
		self.update_column(:route_name, self.route.name)
		self.update_column(:andinists_to_s, andinists.join(', '))
		self.update_fulldate
		self.update_fulldate_for_form
	end
end
