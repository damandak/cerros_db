class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.text :name
      t.text :link
      t.references :referenceable, polymorphic: true

      t.timestamps
    end
  end
end
