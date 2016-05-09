class AddVerificationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verification, :boolean, default: false
  end
end
