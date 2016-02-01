class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.references :submission
      t.references :template

      t.timestamps null: false
    end
  end
end
