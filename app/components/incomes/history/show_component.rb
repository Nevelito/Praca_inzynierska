# frozen_string_literal: true

module Incomes
  module History
    class ShowComponent < ViewComponent::Base
      def initialize(incomes:)
        @incomes = incomes
      end

      private

      attr_reader :incomes
    end
  end
end
