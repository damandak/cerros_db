class Ascent < ApplicationRecord
	belongs_to :route
	has_and_belongs_to_many :andinists
	has_many :sources, as: :referenceable
	
	attr_accessor :ascent_date, :no_month, :no_day

	def fulldate
		day = (self.day and self.day < 10) ? "0" + self.day.to_s : self.day.to_s
		month = (self.month and self.month < 10) ? "0" + self.month.to_s : self.month.to_s
		date_string = self.year.to_s + "-"
		date_string += self.month ? month.to_s + "-" : "xx-"
		date_string += self.day ? day.to_s : "xx"

		# date_string = self.day ? day.to_s + "-" : ""
		# date_string += self.month ? month.to_s + "-" : ""
		# date_string += self.year ? self.year.to_s : ""
    	return date_string
  	end

  	def fulldate_for_form
  		day = (self.day and self.day < 10) ? "0" + self.day.to_s : self.day.to_s
		month = (self.month and self.month < 10) ? "0" + self.month.to_s : self.month.to_s
		date_string = self.year.to_s + "-"
		date_string += self.month ? month.to_s + "-" : "01-"
		date_string += self.day ? day.to_s : "01"

		# date_string = self.day ? day.to_s + "-" : ""
		# date_string += self.month ? month.to_s + "-" : ""
		# date_string += self.year ? self.year.to_s : ""
    	return date_string
  	end
end
