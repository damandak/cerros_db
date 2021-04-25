class Route < ApplicationRecord
	belongs_to :mountain
	has_many :ascents
end
