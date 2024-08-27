# frozen_string_literal: true

module Money
  module Goals
    class OptionButtonsComponent < ViewComponent::Base
      def initialize(goal:)
        @goal = goal
      end

      attr_reader :goal
    end
  end
end
