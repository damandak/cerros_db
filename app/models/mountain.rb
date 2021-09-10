class Mountain < ApplicationRecord
  has_many :routes
  has_many :ascents, through: :routes
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :sectors
  has_one :nomenclatura_object
  has_many :sources, as: :referenceable
  validates :name, presence: true
  has_ancestry
  after_update :update_badges
  after_create :update_badges
  
  has_paper_trail

  attr_accessor :first_country, :second_country, :third_country

  extend FriendlyId
  friendly_id :fullname, use: :slugged
  
  scope :similar_fullname, ->(lookup){
    self.where("(lower(prefix) || ' ' || lower(mountains.name)) LIKE ?", "%#{lookup.downcase}%" )
  }
  scope :in_country, ->(country){
    self.joins(:countries).where(countries: {id: country})
  }

  after_commit :create_unknown_route, on:[ :create ]
  

  def self.ascended
    where previously_ascended: true
  end

  def fullname
    return [self.prefix, self.name].join(" ")
  end

  def fullname_alt
    return [self.alternative_name_prefix, self.alternative_name].join(" ")
  end

  def ascended_str
    if self.previously_ascended then
      return "Sí"
    else
      return "No"
    end
  end

  def first_absolute
    if self.unregistered_sport_ascent then
      return nil
    end
    return self.ascents.sort_by(&:fulldate).first
  end

  def first_winter_absolute
    if self.unregistered_sport_ascent then
      return nil
    end
    winter_ascents = self.ascents.where('month = 7')
    winter_ascents += self.ascents.where('month = 8')
    winter_ascents += self.ascents.where('month = 6').where('day > 20')
    winter_ascents += self.ascents.where('month = 9').where('day < 22')
    return winter_ascents.sort_by(&:fulldate).first
  end

  def winter_ascent
    self.ascents.all.each do |ascent|
      if ascent.month then
        if ascent.month == 7 or ascent.month == 8 then
          return true
        elsif ascent.day then
          if ascent.month == 6 and ascent.day > 20 then
            return true
          elsif ascent.month == 9 and ascent.day < 22 then
            return true
          end
        end
      end    
    end
    return false
  end

  def near_mountains
    if self.latitude and self.longitude then
      dist = 0.04
      lat = self.latitude
      lat_max = lat + dist
      lat_min = lat - dist
      lon = self.longitude
      lon_max = lon + dist
      lon_min = lon - dist
      nears = Mountain.where("latitude > ?", lat_min).where("latitude < ?", lat_max)
      nears = nears.where("longitude > ?", lon_min).where("longitude < ?", lon_max)
      nears = nears.where.not(id: self.id)
      return nears
    else
      return Mountain.where(name: "Nada")
    end
  end

  def self.search(search)
    if search then
      if search[:":similar_fullname"][","] != "" then
        mountains = Mountain.similar_fullname(search[:":similar_fullname"][","])
      else
        mountains = Mountain.all
      end
      if search[:":ascended"] and search[:":ascended"][","] != "None" then
        if search[:":ascended"][","] == "Sí" then
          mountains = mountains.where("previously_ascended = ?", true)
        else
          mountains = mountains.where("previously_ascended = ?", false)
        end
      end
      if search[:":min_height"] and search[:":min_height"][","] != "None" then
        mountains = mountains.where("altitude >= ?", search[:":min_height"][","])
      end
      if search[:":max_height"] and search[:":max_height"][","] != "None" then
        mountains = mountains.where("altitude <= ?", search[:":max_height"][","])
      end
      if search[:":prefix"] and search[:":prefix"][","] != "None" then
        mountains = mountains.where("prefix = ? ", search[:":prefix"][","])
      end
      if search[:":country"] and search[:":country"][","] != "None" then
        mountains = mountains.in_country(search[:":country"][","])
      end
      return mountains
    else
      Mountain.all
    end
  end

  def self.short_search(search)
    if search then
      if search[:":similar_fullname"][","] != "" then
        mountains = Mountain.similar_fullname(search[:":similar_fullname"][","])
      end
      return mountains
    else
      Mountain.all
    end
  end

  private
  def create_unknown_route
    self.routes.create(:name => "Ruta Desconocida", :mountain_id => self.id)
    puts 'Se agregó una Ruta Desconocida al ' + self.name
  end

  def update_badges
    if self.ascents.count > 0 or self.unregistered_sport_ascent then
      self.update_column(:previously_ascended, true)
    else
      self.update_column(:previously_ascended, false)
    end

    self.ascents.each do |ascent|
      route = ascent.route
      if not route.unregistered_sport_ascent and route.ascents.sort_by(&:fulldate).first == ascent then
        ascent.update_column(:first_ascent, true)
        if not self.unregistered_sport_ascent and self.ascents.sort_by(&:fulldate).first == ascent then
          ascent.update_column(:first_absolute, true)
        end
      end

      ascent.andinists.each do |andinist|
        andinist.update_column(:remarkable_ascents, andinist.ascents.count)
        andinist.update_column(:first_absolutes, andinist.ascents.where(:first_absolute => true).count)
        andinist.update_column(:first_ascents, andinist.ascents.where(:first_ascent => true).count)
      end
    end

    
    self.ascents.each do |ascent|
      andinists = []
      ascent.andinists.each do |andinist|
        andinists << andinist.fullname
      end
      ascent.update_column(:mountain_name, ascent.route.mountain.fullname)
      ascent.update_column(:route_name, ascent.route.name)
      ascent.update_column(:andinists_to_s, andinists.join(', '))
      ascent.update_fulldate
      ascent.update_fulldate_for_form
    end
  end

end
