# frozen_string_literal: true

module Money
  module Spendings
    class ShowComponent < ViewComponent::Base
      def initialize(spendings:)
        @spendings = spendings
      end

      private

      attr_reader :spendings
    end
  end
end
