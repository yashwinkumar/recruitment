class AddFieldsToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :location
      t.string :current_employer
      t.string :title
      t.string :experience
      t.text :primary_skills
      t.text :secondary_skills
      t.string :compensation
      t.boolean :on_board
    end
  end
end
