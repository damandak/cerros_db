class NomenclaturaObject < ApplicationRecord
	belongs_to :igm_rectangle
	belongs_to :mountain

	has_paper_trail
end
