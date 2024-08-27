# frozen_string_literal: true

class GoalValidator < BaseValidator
  attr_reader :name, :target_amount, :description, :due_date

  def initialize(params)
    super
    @name = params.dig(:goal, :name)
    @target_amount = params.dig(:goal, :target_amount)
    @description = params.dig(:goal, :description)
    @due_date = params.dig(:goal, :due_date)
  end

  def validate_data
    validate_name?
    validate_target_amount?
    validate_description?
    validate_due_date?
  end

  private

  def validate_name?
    return unless name.nil? || name.length > 50

    errors << I18n.t("errors.goals.invalid_name")
  end

  def validate_target_amount?
    return unless target_amount.nil? || !valid_number?(target_amount) || target_amount.to_f <= 0

    errors << I18n.t("errors.goals.invalid_target_amount")
  end

  def validate_description?
    return unless description.nil? || description.length > 100

    errors << I18n.t("errors.goals.invalid_desription")
  end

  def validate_due_date?
    return unless due_date.nil? || !valid_date?(due_date)

    errors << I18n.t("errors.goals.invalid_date")
  end

  def valid_number?(value)
    Float(value) ? true : false
  rescue ArgumentError, TypeError
    false
  end

  def valid_date?(value)
    parsed_date = Date.parse(value)
    parsed_date > Date.today
  rescue ArgumentError, TypeError
    false
  end
end
