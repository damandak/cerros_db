module ClubsHelper
	def clubs_for_select
  		Club.all.order(:name).pluck(:name).uniq
	end
end
