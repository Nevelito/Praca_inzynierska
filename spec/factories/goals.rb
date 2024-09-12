# frozen_string_literal: true

FactoryBot.define do
  factory :goal do
    name { Faker::Lorem.words(number: 3).join(' ') }
    target_amount { Faker::Commerce.price(range: 100.0..10000.0, as_string: false) }
    description { Faker::Lorem.sentence(word_count: 10)[0..59] }
    due_date { Faker::Date.forward(days: 365) }
    association :user
  end
end
