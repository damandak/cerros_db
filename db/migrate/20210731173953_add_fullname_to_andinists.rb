class AddFullnameToAndinists < ActiveRecord::Migration[6.0]
  def change
    add_column :andinists, :fullname, :string
    Andinist.all.each do |andinist|
      andinist.fullname = [andinist.name,andinist.surname].join(" ")
      andinist.save!
    end
  end
end
