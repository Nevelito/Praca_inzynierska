# frozen_string_literal: true

module Money
  module Incomes
    class ShowComponent < ViewComponent::Base
      def initialize(incomes:)
        @incomes = incomes
      end

      private

      attr_reader :incomes
    end
  end
end
