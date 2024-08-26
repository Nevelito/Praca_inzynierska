# frozen_string_literal: true

module Money
  module Spendings
    class OptionButtonsComponent < ViewComponent::Base
      def initialize(spending:)
        @spending = spending
      end

      attr_reader :spending
    end
  end
end
