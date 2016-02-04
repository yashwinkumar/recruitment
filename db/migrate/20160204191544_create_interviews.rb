class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.references :user
      t.references :job
      t.references :submission
      t.datetime :date
      t.string :description

      t.timestamps null: false
    end
  end
end
