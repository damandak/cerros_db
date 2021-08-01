class AddBadgesToAscents < ActiveRecord::Migration[6.0]
  def change
    add_column :ascents, :first_absolute, :boolean
    add_column :ascents, :first_ascent, :boolean

    Ascent.all.each do |ascent|
      route = ascent.route
      mountain = route.mountain
      if not route.unregistered_sport_ascent and ascent.route.ascents.sort_by(&:fulldate).first == ascent
        ascent.update_column(:first_ascent, true)
        if not mountain.unregistered_sport_ascent and ascent.route.mountain.ascents.sort_by(&:fulldate).first == ascent then
          ascent.update_column(:first_absolute, true)
        end
      end
    end


    Andinist.all.each do |andinist|
      andinist.update_column(:remarkable_ascents, andinist.ascents.count)
      andinist.update_column(:first_absolutes, andinist.ascents.where(:first_absolute => true).count)
      andinist.update_column(:first_ascents, andinist.ascents.where(:first_ascent => true).count)
    end
  end
end
