# frozen_string_literal: true
module Money
  module Spendings
    class DetailComponent < ViewComponent::Base
      def initialize(text:, amount:)
        @text = text
        @amount = amount
      end

      private

      attr_reader :text, :amount
    end
  end
end
