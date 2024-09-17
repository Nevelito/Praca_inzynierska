# frozen_string_literal: true

class IncomeValidator < BaseValidator
  attr_reader :amount, :date, :description

  def initialize(params)
    super
    @amount = params.dig(:income, :amount)
    @date = params.dig(:income, :date)
    @description = params.dig(:income, :description)
  end

  def validate_data
    validate_amount?
    validate_date?
    validate_description?

    self
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

  def validate_description?
    return unless description.nil? || description.length > 60

    errors << I18n.t("errors.incomes.invalid_desription")
  end

  def valid_number?(value)
    Float(value) ? true : false if value.present?
  end

  def valid_date?(value)
    Date.parse(value)
  rescue StandardError
    false
  end
end
