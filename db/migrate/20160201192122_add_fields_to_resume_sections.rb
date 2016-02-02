class AddFieldsToResumeSections < ActiveRecord::Migration
  def change
    add_column :resume_sections, :video, :string
    add_column :resume_sections, :rating, :integer
  end
end
