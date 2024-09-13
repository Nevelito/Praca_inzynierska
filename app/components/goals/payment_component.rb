# frozen_string_literal: true

module Goals
  class PaymentComponent < ViewComponent::Base
    with_collection_parameter :goal_payment

    def initialize(goal_payment:)
      @goal_payment = goal_payment
    end

    private

    attr_reader :goal_payment

    def date
      goal_payment.payment_date
    end
  end
end
