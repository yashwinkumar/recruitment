require 'rails_helper'
require 'spec_helper'

RSpec.describe Template do
	subject {Template.new}

	it "is not valid without a name" do
		expect(subject).not_to be_valid
	end
    
    it "is not valid with a name longer than 100 symbols" do
    	subject.name = 'a' * 101
		expect(subject).not_to be_valid
	end
end
