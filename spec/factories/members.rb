require 'faker'
FactoryGirl.define do
  factory :member do
    name { Faker::Name.name_with_middle }
    phone { Faker::Number.number(10) }
    address { Faker::Address.street_address }
    gender { Faker::Boolean.boolean(1) }
    validity_date { Faker::Date.between(2.days.ago, Date.today).strftime("%F") }
    code { Faker::Number.number(4) }
    is_author { Faker::Boolean.boolean(1) }
    library_id { FactoryGirl.create(:library).id }
  end
end
