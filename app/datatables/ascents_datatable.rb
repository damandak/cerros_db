class AscentsDatatable < ApplicationDatatable

	private
	def data
		ascents.map do |ascent|
			[].tap do |column|
				column << ascent.id
				column << link_to(ascent.mountain_name, mountain_path(ascent.route.mountain))
				column << link_to(ascent.route_name, route_path(ascent.route))
				column << ascent.name
				column << ascent.andinists_to_s
				column << ascent.fulldate
			end

		end
	end

	def count
		Ascent.count
	end

	def total_entries
		ascents.total_count
	end

	def ascents
		@ascents ||= fetch_ascents
	end

	def fetch_ascents
		search_string = []
		columns.each do |term|
			search_string << "lower(#{term}::text) like lower(:search)"
		end
		ascents = Ascent.order("#{sort_column} #{sort_direction}").order(:id)
		ascents = ascents.page(page).per(per_page)
		ascents = ascents.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
	end

	def columns
		%w(id mountain_name route_name name andinists_to_s fulldate)
		# Falta agregar otras columnas y corregir la de fecha. Para esto, tal vez sea necesario agregarlas a schema!!
	end
end