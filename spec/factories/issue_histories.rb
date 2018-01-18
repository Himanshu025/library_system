require 'faker'
FactoryGirl.define do
  factory :issue_history do
    issue_type %w[rent return].sample
    issue_date Faker::Date.between(2.days.ago, Date.today).strftime("%F")
    return_date Faker::Date.between(2.days.ago, Date.today).strftime("%F")
    member_id { FactoryGirl.create(:member).id }
    book_id { FactoryGirl.create(:book).id }
  end
end