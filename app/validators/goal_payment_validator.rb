# frozen_string_literal: true

class GoalPaymentValidator < BaseValidator
  attr_reader :amount, :goal_id

  def initialize(params)
    super
    @amount = params.dig(:goal_payment, :amount)
    @goal_id = params.dig(:goal_payment, :goal_id)
  end

  def validate_data
    validate_amount?
    validate_goal_id?
    self
  end

  private

  def validate_amount?
    return unless amount.nil? || !valid_number?(amount) || amount.to_f <= 0

    errors << I18n.t("errors.goal_payments.invalid_amount")
  end

  def validate_goal_id?
    return unless !valid_goal?

    errors << I18n.t("errors.goal_payments.invalid_goal")
  end

  def valid_goal?
    Goal.exists?(id: goal_id)
  end

  def valid_number?(value)
    Float(value) ? true : false
  rescue ArgumentError, TypeError
    false
  end
end
