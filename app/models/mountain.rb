class Mountain < ApplicationRecord
  has_many :routes
  has_many :ascents, through: :routes
  has_one :nomenclatura_object
  validates :name, presence: true

  after_commit :create_unknown_route, on:[ :create ]

  paginates_per 20
  def fullname
    return [self.prefix,self.name].join(" ")
  end

  def ascended
    if self.ascents.count > 0
      return "Sí"
    else
      return "No"
    end
  end

  private
  def create_unknown_route
    self.routes.create(:name => "Ruta Desconocida", :mountain_id => self.id)
    puts 'Se agregó una Ruta Desconocida al ' + self.name
  end
 

end
