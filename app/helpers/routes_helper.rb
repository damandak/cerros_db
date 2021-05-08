module RoutesHelper
	def routes_for_select(mountain)
  		Route.where(:mountain_id => mountain.id).collect { |a| [[a.name, mountain.fullname].join(" - "), a.id] }
	end
end
