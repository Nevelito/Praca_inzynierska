# frozen_string_literal: true

module Money
  module Goals
    class DetailComponent < ViewComponent::Base
      with_collection_parameter :goal

      def initialize(goal:)
        @goal = goal
      end

      private

      attr_reader :goal

      def saved_money
        goal.goal_payments.sum(:amount)
      end
    end
  end
end
