# frozen_string_literal: true

FactoryBot.define do
  factory :spending do
    amount { Faker::Commerce.price(range: 0..1000.0, as_string: false) }
    user { create(:user) }
    kind { Spending.kinds.keys.sample }
    description { Faker::Lorem.sentence(word_count: 10)[0..59] }
    date { Faker::Date.between(from: 2.years.ago, to: Date.today) }
  end
end
