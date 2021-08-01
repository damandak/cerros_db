class AddHelpersToAscents < ActiveRecord::Migration[6.0]
  def change
    add_column :ascents, :mountain_name, :string
    add_column :ascents, :route_name, :string
    add_column :ascents, :andinists_to_s, :string
    add_column :ascents, :fulldate, :string
    add_column :ascents, :fulldate_for_form, :string


    Ascent.all.each do |ascent|
      day = (ascent.day and ascent.day < 10) ? "0" + ascent.day.to_s : ascent.day.to_s
      month = (ascent.month and ascent.month < 10) ? "0" + ascent.month.to_s : ascent.month.to_s
      date_string = ascent.year.to_s + "-"
      date_string += ascent.month ? month.to_s + "-" : "xx-"
      date_string += ascent.day ? day.to_s : "xx"

      date_string_form = ascent.year.to_s + "-"
      date_string_form += ascent.month ? month.to_s + "-" : "01-"
      date_string_form += ascent.day ? day.to_s : "01"

      andinists = []
      ascent.andinists.order("fullname").each do |andinist|
        andinists << andinist.fullname
      end
      ascent.update_column(:mountain_name, ascent.route.mountain.fullname)
      ascent.update_column(:route_name, ascent.route.name)
      ascent.update_column(:andinists_to_s, andinists.join(', '))
      ascent.update_column(:fulldate, date_string)
      ascent.update_column(:fulldate_for_form, date_string_form)
    end

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
