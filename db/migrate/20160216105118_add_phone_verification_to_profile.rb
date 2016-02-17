class AddPhoneVerificationToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :phone_verified, :boolean, default: false
    add_column :profiles, :phone_verification_code, :string
  end
end
