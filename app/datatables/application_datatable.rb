class ApplicationDatatable
	delegate :params, to: :@view
	delegate :link_to, to: :@view
	delegate :mountain_path, to: :@view
	delegate :ascent_path, to: :@view
	delegate :andinist_path, to: :@view
	delegate :route_path, to: :@view

	def initialize(view)
		@view = view
	end

	def as_json(options = {} )
		{
			recordsTotal: count,
			recordsFiltered: total_entries,
			data: data
		}
	end

	private

	def page
		params[:start].to_i / per_page + 1
	end

	def per_page
		params[:length].to_i > 0 ? params[:length].to_i : 10
	end

	def sort_column
		columns[params[:order]['0'][:column].to_i]
	end

	def sort_direction
		params[:order]['0'][:dir] == "desc" ? "desc" : "asc"
	end
end