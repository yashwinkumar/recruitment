class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :template
      t.string :title
      t.string :description
      t.string :location

      t.timestamps null: false
    end
  end
end
