module UserOnBoard
  extend ActiveSupport::Concern

  included do
    before_save :onboardable?
    before_save :generate_phone_code, if: :phone_changed?
  end

  def on_board_attributes
    status = ['first_name', 'last_name', 'phone', 'location'].map do |k, v|
      if attributes[k] == "" || attributes[k].nil?
        false
      else
        true
      end
    end.include?(false)
    !status
  end

  def onboardable?
    if on_board_attributes && phone_verified
      self.on_board =  true
    end
  end

  def phone_verification
    generate_phone_code
    self.save!
  end

  private

  def send_pin
    begin
      client = Twilio::REST::Client.new
      client.messages.create(
        from: "+14242851283",
        to: self.phone,
        body: "Your PIN #{self.phone_verification_code} to verify."
      )
    rescue Exception => e
      self.errors.add(:phone, "Phone number not valid")
    end
  end

  def generate_phone_code
    self.phone_verification_code = rand(0000..9999).to_s.rjust(4, "0")
    self.phone_verified = false
    self.on_board = false
    send_pin
  end

end