# frozen_string_literal: true

module Money
  module Currencies
    class CalculatorComponent < ViewComponent::Base
      attr_reader :currencies

      def initialize(currencies:)
        @currencies = currencies
      end
    end
  end
end
