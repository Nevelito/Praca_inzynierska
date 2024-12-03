# frozen_string_literal: true

class SpendingValidator < BaseValidator
  attr_reader :amount, :date, :kind, :description

  VALID_KINDS = %w[house car healthcare entertaiment restaurant shopping groceries other].freeze

  def initialize(params)
    super
    @amount = params.dig(:spending, :amount)
    @date = params.dig(:spending, :date)
    @kind = params.dig(:spending, :kind)
    @description = params.dig(:spending, :description)
  end

  def validate_data
    validate_amount?
    validate_date?
    validate_kind?
    validate_description?

    self
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

  def validate_description?
    return unless description.nil? || description.length > 60

    errors << I18n.t("errors.spendings.invalid_desription")
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
