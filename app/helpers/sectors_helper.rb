module SectorsHelper

	def sectors_categories_for_select
  		Sector.all.order(:category).pluck(:category).uniq
	end

	def sectors_for_select(category)
		Sector.where(:category => category).collect { |a| [a.name, a.id] }
	end
end
