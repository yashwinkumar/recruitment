class AddMoreFieldsToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.string :middle_name
      t.boolean :relocate
      t.string :jobs_interested
      t.string :expecting_job_rate
      t.boolean :citizen
    end
  end
end
