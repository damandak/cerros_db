module RoutesHelper
	def routes_for_select(mountain)
  		Route.where(id: mountain.id).collect { |a| [a.name, a.id] }
	end
end
