require 'rails_helper'
require 'spec_helper'

RSpec.describe Template, type: :model do
	it { is_expected.to validate_presence_of(:name) }
	it { is_expected.to validate_length_of(:name).is_at_least(5) }
	it { is_expected.to validate_presence_of(:user_id) }
	it {should validate_numericality_of(:user_id).only_integer }
end
