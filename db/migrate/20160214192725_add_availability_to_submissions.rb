class AddAvailabilityToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :availability_1, :datetime
    add_column :submissions, :availability_2, :datetime
    add_column :submissions, :availability_3, :datetime
  end
end
