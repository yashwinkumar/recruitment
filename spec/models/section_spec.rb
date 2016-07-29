require 'rails_helper'
require 'spec_helper'

RSpec.describe Section, type: :model do
	it "is valid with template_id and name" do
		section = Section.new(
			template_id: 1,
			name: 'ruby on rails')
		expect(section).to be_valid
	end

	it "is invalid without a name" do
		section = Section.new(name: nil)
		section.valid?
		expect(section.errors[:name]).to include("can't be blank")
	end
end
