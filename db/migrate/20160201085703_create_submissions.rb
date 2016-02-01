class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user
      t.references :resume
      t.references :job

      t.timestamps null: false
    end
  end
end
