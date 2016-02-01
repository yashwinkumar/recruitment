class CreateResumeSections < ActiveRecord::Migration
  def change
    create_table :resume_sections do |t|
      t.references :section
      t.references :resume

      t.timestamps null: false
    end
  end
end
