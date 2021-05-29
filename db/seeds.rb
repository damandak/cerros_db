# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# IGM_Rectangles

csv_text = File.read(Rails.root.join('lib', 'seeds', 'igm_rectangles.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  igm = IgmRectangle.new
  igm.name = row['name']
  igm.file_id = row['file_id']
  igm.save
  # puts "#{igm.name}, #{igm.file_id} saved"
end
puts "IGM OK"

# Country Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'country.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  country = Country.new
  country.name = row['name']
  country.save!
end
puts "Countries OK"

# Mountain Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'mountain.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  mount = Mountain.new
  mount.name = row['name']
  mount.prefix = row['prefix']
  mount.altitude = row['altitude']
  mount.latitude = row['latitude']
  mount.longitude = row['longitude']
  mount.alternative_name_prefix = row['alternative_name_prefix']
  mount.alternative_name = row['alternative_name']
  mount.secondary_altitude = row['secondary_altitude']
  mount.secondary_altitude_name = row['secondary_altitude_name']
  if row['country_a'] != "" then
    if country = Country.where(:id => row['country_a']).first
      mount.country_ids = mount.country_ids << country.id
    end
  end
  if row['country_b'] != "" then
    if country = Country.where(:id => row['country_b']).first
      mount.country_ids = mount.country_ids << country.id
    end
  end

  mount.save!
  # puts "#{mount.name} saved"
end
puts "Mountains OK"

# Nomenclature Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'nomenclature_objects.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  nom = NomenclaturaObject.new
  nom.revision_code = row['revision_code']
  nom.name = row['name']
  nom.altitude_igm = row['altitude_igm']
  nom.latitude_south = row['latitude_south']
  nom.longitude_west = row['longitude_west']
  nom.observations = row['observations']
  nom.comment = row['comment']
  nom.igm_rectangle_id = row['igm_rectangle_id']
  nom.mountain_id = row['mountain_id']
  nom.save!
  # puts "#{nom.name} saved"
end
puts "Nomenclature OK"

# Ascent Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'ascent.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  asc = Ascent.new
  asc.year = row['year']
  asc.month = row['month']
  asc.day = row['day']
  asc.name = row['name']
  asc.route_id = row['route_id']
  asc.save!
  # puts "#{asc.name} saved"
end
puts "Ascents OK"

# Andinist Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'andinist.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  andi = Andinist.new
  andi.name = row['name']
  andi.surname = row['surname']

  if row['club'] and row['club'] != "" then
    if Club.all.where(:name => row['club']).count > 0 then
      club = Club.all.where(:name => row['club']).first
    else
      club = Club.new
      club.name = row['club']
      club.save!
    end
    andi.club_ids = andi.club_ids << club.id
  end

  if row['otro_club'] and row['otro_club'] != ""  then
    if Club.all.where(:name => row['otro_club']).count > 0 then
      club = Club.all.where(:name => row['otro_club']).first
    else
      club = Club.new
      club.name = row['otro_club']
      club.save!
    end
    andi.club_ids = andi.club_ids << club.id
  end

  if row['country'] != "" then
    if country = Country.where(:id => row['country']).first
      andi.country_ids = andi.country_ids << country.id
    end
  end
  andi.gender = row['genero']
  andi.save!
  # puts "#{andi.name} saved"
end
puts "Andinists OK"

# Andinist_Ascents Objects
csv_text = File.read(Rails.root.join('lib', 'seeds', 'andinist_ascent.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
	if andinist = Andinist.where(:id => row['id_andinist']).first
		if ascent = Ascent.where(:id => row['id_ascent']).first
			ascent.andinist_ids = ascent.andinist_ids << andinist.id
		end
	end
  # puts "#{andi.name} saved"
end
puts "AndinistsAscents OK"

rm = Sector.new
rv = Sector.new
rvi = Sector.new
rvii = Sector.new
rm.name = "Región Metropolitana"
rv.name = "Región de Valparaíso"
rvi.name = "Región del Libertador General Bernardo O'Higgins"
rvii.name = "Región del Maule"
rm.category = "Regiones de Chile"
rv.category = "Regiones de Chile"
rvi.category = "Regiones de Chile"
rvii.category = "Regiones de Chile"
rm.img_url = "https://www.elperiscopio.cl/wp-content/uploads/2020/03/1547470176156-820x385.jpg"
rvi.img_url = "https://www.sextanoticias.cl/wp-content/uploads/2020/09/Sector-Cortaderal_2.jpg"
rvii.img_url = "https://farm3.staticflickr.com/2742/4311871839_b992a3b355_b.jpg"
rv.img_url = "http://conociendochile.com/wp-content/uploads/2018/03/region-de-Valparaiso-4.jpg"
rm.save
rv.save
rvi.save
rvii.save
puts "Sectors OK"

u = User.new
u.email = "admin@admin.com"
u.superadmin_role = true
u.password = "123456789"
u.password_confirmation = "123456789"
u.save!
puts "Users OK"
