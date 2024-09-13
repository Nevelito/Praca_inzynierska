# frozen_string_literal: true

FactoryBot.define do
  factory :goal_payment do
    amount { Faker::Commerce.price(range: 10.0..1000.0, as_string: false) }
    payment_date { Faker::Date.between(from: 2.years.ago, to: Date.today) }
    association :goal
    association :user
  end
end
