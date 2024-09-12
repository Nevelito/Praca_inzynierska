# frozen_string_literal: true

module Spendings
  module History
    class ShowComponent < ViewComponent::Base
      def initialize(spendings:)
        @spendings = spendings
      end

      private

      attr_reader :spendings
    end
  end
end
