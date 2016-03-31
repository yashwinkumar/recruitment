class AddLabelToComments < ActiveRecord::Migration
  def change
    add_column :comments, :label, :string
  end
end
