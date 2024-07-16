# frozen_string_literal: true

class SpendingValidator < BaseValidator
  attr_reader :amount, :month, :year, :kind

  VALID_KINDS = %w[house car health_care pleasure food other]

  def initialize(params)
    super
    @amount = params.dig(:income, :amount)
    @month = params.dig(:income, :month)
    @year = params.dig(:income, :year)
    @kind = params.dig(:income, :kind)
  end

  def validate_data
    validate_amount?
    validate_month?
    validate_year?
    validate_kind?
  end

  private

  def validate_amount?
    if amount.nil? || !valid_number?(amount) || amount.to_f <= 0
      errors << "nieprawidłowa wartość"
    end
  end

  def validate_month?
    if month.nil? || !valid_integer?(month) || !month.to_i.between?(1, 12)
      errors << "nieprawidłowa miesiac"
    end
  end

  def validate_year?
    current_year = Date.today.year
    if year.nil? || !valid_integer?(year) || !year.to_i.between?(1900, current_year)
      errors << "nieprawidłowa rok"
    end
  end

  def validate_kind?
    unless VALID_KINDS.include?(kind)
      errors << "nieprawidłowa kategoria"
    end
  end

  def valid_number?(value)
    Float(value) ? true : false
  end

  def valid_integer?(value)
    Integer(value) ? true : false
  end
end
