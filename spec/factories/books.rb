require 'faker'
FactoryGirl.define do
  factory :book do
    name Faker::Book.title
    author Faker::Book.author
    isbn Faker::Code.isbn
    price Faker::Number.decimal(3,2)
    publication Faker::Book.publisher
    version Faker::Number.between(1, 10)
    no_of_copies Faker::Number.between(1, 20)
    library_id { FactoryGirl.create(:library).id }
    category_id { FactoryGirl.create(:category).id}
  end
end