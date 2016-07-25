require 'faker'

FactoryGirl.define do
  factory :template do |f|
    f.name { Faker::Template.name}
    f.user_id { Faker::Template.user_id}
  end
end
