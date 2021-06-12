module CountriesHelper
	def countries_for_mountain_select
  		Country.with_mountains.collect { |a| [a.name, a.id] }
	end

	def countries_for_select
  		Country.all.order(:name).pluck(:name).uniq
	end
end
