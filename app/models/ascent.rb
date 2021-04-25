class Ascent < ApplicationRecord
	belongs_to :route
	has_and_belongs_to_many :andinists
	attr_accessor :ascent_date, :route_name, :andinist_lala
end
