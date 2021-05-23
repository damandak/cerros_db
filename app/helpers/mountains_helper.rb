module MountainsHelper
	def prefix_for_select
  		Mountain.all.order(:prefix).pluck(:prefix).uniq
	end
	def mountains_for_select
  		Mountain.all.collect { |a| [a.fullname, a.id] }
	end
end
