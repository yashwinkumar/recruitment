class AddFieldsToJobs < ActiveRecord::Migration
  def change
    change_table :jobs do |t|
      t.string :job_type
      t.string :compensation
      t.string :experience
      t.string :duration
      t.date :start_date
    end
  end
end
