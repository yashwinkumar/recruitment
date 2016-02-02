class AddHiringManagerToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :hiring_user_id, :integer
    add_column :jobs, :consultant_user_id, :integer
  end
end
