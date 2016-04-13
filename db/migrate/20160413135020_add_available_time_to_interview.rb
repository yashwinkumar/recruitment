class AddAvailableTimeToInterview < ActiveRecord::Migration
  def change
    add_column :interviews, :available_time_id, :integer
  end
end
