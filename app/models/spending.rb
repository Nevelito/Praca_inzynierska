class Spending < ApplicationRecord
  belongs_to :user

  enum kind: { house: "house", car: "car", health_care: "health_care", pleasure: "pleasure", food: "food", other: "other" }
end
