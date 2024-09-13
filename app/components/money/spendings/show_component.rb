# frozen_string_literal: true
module Money
  module Spendings
    class ShowComponent < ViewComponent::Base
      def initialize(spendings:, date:)
        @spendings = spendings
        @date = date
      end

      private

      attr_reader :spendings, :date

      def spendings_today
        spendings.where(date: date).sum(&:amount)
      end

      def spendings_this_month
        spendings.where(date: date.beginning_of_month..date.end_of_month)
                 .sum(&:amount)
      end
    end
  end
end
