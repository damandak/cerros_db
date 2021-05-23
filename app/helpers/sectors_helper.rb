module SectorsHelper

	def sectors_categories_for_select
  		Sector.all.order(:category).pluck(:category).uniq
	end

end
