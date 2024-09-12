# frozen_string_literal: true

module Money
  class BalanceComponent < ViewComponent::Base
    attr_reader :text, :balance

    def initialize(text:, balance:)
      @text = text
      @balance = balance
    end

    def render?
      balance.present?
    end

    def color
      balance < 0 ? "text-red-500" : "text-green-500"
    end
  end
end
