class GoalPayment < ApplicationRecord
  attr_accessor :currency

  belongs_to :goal
  belongs_to :user
end
