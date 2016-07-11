class AddHiringDateToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :hiring_date, :datetime
  end
end
