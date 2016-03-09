class ChangeJobDescriptionType < ActiveRecord::Migration
  def up
    change_column :jobs, :description, :text
  end

  def down
    remove_column :jobs, :description, :string
  end
end
