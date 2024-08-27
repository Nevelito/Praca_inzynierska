# frozen_string_literal: true

module Money
  module Goals
    class ShowComponent < ViewComponent::Base
      def initialize(goals:)
        @goals = goals
      end

      private

      attr_reader :goals
    end
  end
end
