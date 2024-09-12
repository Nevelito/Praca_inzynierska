# frozen_string_literal: true

module Spendings
  module History
    class OptionButtonsComponent < ViewComponent::Base
      def initialize(spending:)
        @spending = spending
      end

      attr_reader :spending
    end
  end
end
