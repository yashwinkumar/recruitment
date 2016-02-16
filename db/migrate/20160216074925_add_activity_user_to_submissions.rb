class AddActivityUserToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :activity_user_id, :integer
  end
end
