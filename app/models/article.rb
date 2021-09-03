class Article < ApplicationRecord
	has_and_belongs_to_many :andinists

	paginates_per 5

	has_paper_trail
  
end
