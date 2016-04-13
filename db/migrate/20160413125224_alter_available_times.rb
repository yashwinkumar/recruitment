class AlterAvailableTimes < ActiveRecord::Migration
  def change
    remove_column :submissions, :availability_1
    remove_column :submissions, :availability_2
    remove_column :submissions, :availability_3
    remove_column :available_times, :time_from
    remove_column :available_times, :time_to

    add_column :available_times, :from, :string
    add_column :available_times, :to, :string
    add_column :available_times, :zone, :string
  end
end
