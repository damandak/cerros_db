class Ascent < ApplicationRecord
	belongs_to :route
	has_and_belongs_to_many :andinists
	attr_accessor :ascent_date, :route_name, :andinist_lala

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
end
