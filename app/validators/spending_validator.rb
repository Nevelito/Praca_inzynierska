# frozen_string_literal: true

class SpendingValidator < BaseValidator
  attr_reader :amount, :date, :kind

  VALID_KINDS = %w[house car healthcare entertaiment restaurant shopping groceries other].freeze

  def initialize(params)
    super
    @amount = params.dig(:spending, :amount)
    @date = params.dig(:spending, :date)
    @kind = params.dig(:spending, :kind)
  end

  def validate_data
    validate_amount?
    validate_date?
    validate_kind?
  end

  private

  def validate_amount?
    return unless amount.nil? || !valid_number?(amount) || amount.to_f <= 0

    errors << I18n.t("errors.spendings.invalid_amount")
  end

  def validate_date?
    return unless date.nil? || !valid_date?(date)

    errors << I18n.t("errors.spendings.invalid_date")
  end

  def validate_kind?
    return if VALID_KINDS.include?(kind)

    errors << I18n.t("errors.spendings.invalid_kind")
  end

  def valid_number?(value)
    Float(value) ? true : false
  end

  def valid_date?(value)
    Date.parse(value)
  rescue StandardError
    false
  end
end
