class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :picture
      t.date :dob

      t.timestamps null: false
    end
  end
end
