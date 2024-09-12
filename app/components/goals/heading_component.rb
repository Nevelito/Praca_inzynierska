# frozen_string_literal: true

module Goals
  class HeadingComponent < ViewComponent::Base
    def initialize(goal:, goal_payments:)
      @goal = goal
      @goal_payments = goal_payments
    end

    private

    attr_reader :goal, :goal_payments

    def saved_money
      goal_payments.sum(&:amount)
    end
  end
end
