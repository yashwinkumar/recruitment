class AddConsultantRatingsToResumeSection < ActiveRecord::Migration
  def change
    add_column :resume_sections, :consultant_rating, :integer
    add_column :resume_sections, :hiring_manager_rating, :integer
  end
end
