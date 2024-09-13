# frozen_string_literal: true

module Incomes
  module History
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
