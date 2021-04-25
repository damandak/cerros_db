class CreateIgmRectangles < ActiveRecord::Migration[6.0]
  def change
    create_table :igm_rectangles do |t|
      t.string :name
      t.string :file_id

      t.timestamps
    end
  end
end
