# frozen_string_literal: true

module Money
  module Incomes
    class DetailComponent < ViewComponent::Base
      with_collection_parameter :income

      def initialize(income:)
        @income = income
      end

      private

      attr_reader :income

      def date
        income.date
      end
    end
  end
end
