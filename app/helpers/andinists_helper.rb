module AndinistsHelper
	def andinists_for_select
  		Andinist.all.collect { |a| [a.fullname, a.id] }
	end
end
