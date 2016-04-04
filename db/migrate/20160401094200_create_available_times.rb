class CreateAvailableTimes < ActiveRecord::Migration
  def change
    create_table :available_times do |t|
      t.references :submission
      t.date :date
      t.time :time_from
      t.time :time_to
      t.timestamps null: false
    end
  end
end
