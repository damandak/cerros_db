class Article < ApplicationRecord
	has_and_belongs_to_many :andinists

	has_paper_trail
  
end
