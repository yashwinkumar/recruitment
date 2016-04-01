class AlterProfileFields < ActiveRecord::Migration
  def change
    remove_column :profiles, :relocate
    remove_column :profiles, :expecting_job_rate
    add_column :profiles, :preferred_locations, :text
    add_column :profiles, :expected_salary, :string
    change_column :profiles, :citizen, :string
  end
end
