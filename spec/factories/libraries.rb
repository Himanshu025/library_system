require 'faker'
FactoryGirl.define do
  factory :library do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    phone { Faker::Number.number(10) }
  end
end
