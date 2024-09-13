# frozen_string_literal: true

module Incomes
  module History
    class OptionButtonsComponent < ViewComponent::Base
      def initialize(income:)
        @income = income
      end

      attr_reader :income
    end
  end
end
