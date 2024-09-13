# frozen_string_literal: true

class IncomeValidator < BaseValidator
  attr_reader :amount, :date

  def initialize(params)
    super
    @amount = params.dig(:income, :amount)
    @date = params.dig(:income, :date)
  end

  def validate_data
    validate_amount?
    validate_date?
  end

  private

  def validate_amount?
    return unless amount.nil? || !valid_number?(amount) || amount.to_f <= 0

    errors << I18n.t("errors.incomes.invalid_amount")
  end

  def validate_date?
    return unless date.nil? || !valid_date?(date)

    errors << I18n.t("errors.incomes.invalid_date")
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
