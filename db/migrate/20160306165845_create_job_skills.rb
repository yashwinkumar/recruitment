class CreateJobSkills < ActiveRecord::Migration
  def change
    create_table :job_skills do |t|
      t.references :job, index: true
      t.references :skill, index: true

      t.timestamps null: false
    end
  end
end
