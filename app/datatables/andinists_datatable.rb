class AndinistsDatatable < ApplicationDatatable

	private
	def data
		andinists.map do |andinist|
			[].tap do |column|
				column << andinist.id
				column << link_to(andinist.fullname, andinist_path(andinist))
				column << andinist.country_to_s
				column << andinist.club_to_s
				column << andinist.remarkable_ascents
				column << andinist.first_absolutes
				column << andinist.first_ascents
			end

		end
	end

	def count
		Andinist.count
	end

	def total_entries
		andinists.total_count
	end

	def andinists
		@andinists ||= fetch_andinists
	end

	def fetch_andinists
		search_string = []
		columns.each do |term|
			search_string << "lower(#{term}::text) like lower(:search)"
		end
		andinists = Andinist.order("#{sort_column} #{sort_direction}").order(:id)
		andinists = andinists.page(page).per(per_page)
		andinists = andinists.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
	end

	def columns
		%w(id fullname country_to_s club_to_s remarkable_ascents first_absolutes first_ascents)
	end
end