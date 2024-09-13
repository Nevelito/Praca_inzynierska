# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, special_characters: true) + rand(0..9).to_s + "wW" }
  end
end
