class Mountain < ApplicationRecord
  has_many :routes
  has_many :ascents, through: :routes
  has_and_belongs_to_many :countries
  has_one :nomenclatura_object
  validates :name, presence: true

  scope :with_ascents, -> {
    self.joins(:ascents).distinct
  }
  scope :without_ascents, -> {
    self.left_outer_joins(:ascents).where(ascents: {id: nil})
  }
  scope :similar_fullname, ->(lookup){
    self.where("(lower(prefix) || ' ' || lower(mountains.name)) LIKE ?", "%#{lookup.downcase}%" )
  }
  scope :in_country, ->(country){
    self.joins(:countries).where(countries: {id: country})
  }

  after_commit :create_unknown_route, on:[ :create ]
  
  def ascended?
    if self.ascents.count > 0 or self.previously_ascended then
      return true
    else
      return false
    end
  end

  def self.ascended
    where ascended: true
  end

  def fullname
    return [self.prefix, self.name].join(" ")
  end

  def fullname_alt
    return [self.alternative_name_prefix, self.alternative_name].join(" ")
  end

  def ascended_str
    if self.ascended? then
      return "Sí"
    else
      return "No"
    end
  end

  def first_absolute
    return self.ascents.sort_by(&:fulldate).first
  end

  def first_winter_absolute
    winter_ascents = self.ascents.where('month = 7')
    winter_ascents += self.ascents.where('month = 8')
    winter_ascents += self.ascents.where('month = 6').where('day > 20')
    winter_ascents += self.ascents.where('month = 9').where('day < 22')
    return winter_ascents.sort_by(&:fulldate).first
  end

  def solo_ascent
    self.ascents.all.each do |ascent|
      if ascent.andinists.count == 1 then
        return true
      end
    end
    return false
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
  end

  def self.search(search)
    if search then
      if search[:":similar_fullname"][","] != "" then
        mountains = Mountain.similar_fullname(search[:":similar_fullname"][","])
      else
        mountains = Mountain.all
      end
      if search[:":ascended"] then
        if search[:":ascended"][","] == "Sí" then
          mountains = mountains.with_ascents
        elsif search[:":ascended"][","] == "No" then
          mountains = mountains.without_ascents
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


end
