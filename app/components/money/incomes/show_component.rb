# frozen_string_literal: true
module Money
  module Incomes
    class ShowComponent < ViewComponent::Base
      def initialize(incomes:, date:)
        @incomes = incomes
        @date = date
      end

      private

      attr_reader :incomes, :date

      def incomes_today
        incomes.where(date: date).sum(:amount)
      end

      def incomes_this_month
        incomes.where(date: date.beginning_of_month..date.end_of_month)
                 .sum(:amount)
      end
    end
  end
end
