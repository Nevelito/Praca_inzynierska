# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :spendings
  has_many :incomes
  has_many :goals, dependent: :destroy
  has_many :goal_payments, through: :goals

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
