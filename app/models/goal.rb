class Goal < ApplicationRecord
  attr_accessor :currency

  belongs_to :user
  has_many :goal_payments, dependent: :destroy
end
