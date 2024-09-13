# frozen_string_literal: true

class GoalPaymentValidator < BaseValidator
  attr_reader :amount

  def initialize(params)
    super
    @amount = params.dig(:goal_payment, :amount)
  end

  def validate_data
    validate_amount?
  end

  private

  def validate_amount?
    return unless amount.nil? || !valid_number?(amount) || amount.to_f <= 0

    errors << I18n.t("errors.goal_payments.invalid_amount")
  end

  def valid_number?(value)
    Float(value) ? true : false
  rescue ArgumentError, TypeError
    false
  end
end
