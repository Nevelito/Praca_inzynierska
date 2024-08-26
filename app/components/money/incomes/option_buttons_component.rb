# frozen_string_literal: true

module Money
  module Incomes
    class OptionButtonsComponent < ViewComponent::Base
      def initialize(income:)
        @income = income
      end

      attr_reader :income
    end
  end
end
