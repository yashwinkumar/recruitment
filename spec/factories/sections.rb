require 'faker'
FactoryGirl.define do
  factory :section do |s|
    s.name { Faker::Section.name}
    s.template_id { Faker::Section.template_id}
  end
end
