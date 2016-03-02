class AddModeToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :mode, :string
  end
end
