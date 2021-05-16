module MountainsHelper
	def prefix_for_select
  		Mountain.all.order(:prefix).pluck(:prefix).uniq
	end
end
