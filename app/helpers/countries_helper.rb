module CountriesHelper
	def countries_for_select
  		Country.with_mountains.collect { |a| [a.name, a.id] }
	end
end
