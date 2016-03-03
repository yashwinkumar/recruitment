class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :submission
      t.string :name
      t.string :file

      t.timestamps null: false
    end
  end
end
