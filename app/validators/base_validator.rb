# frozen_string_literal: true

class BaseValidator
  attr_accessor :errors

  def initialize(_params)
    @errors = Set.new
  end

  def success?
    errors.blank?
  end

  def frontline_errors
    errors << ""
    errors.join("<br>")
  end

  private

  def is_empty?(value)
    result = value.nil? || value.blank? || value.empty?
    blank_error if result
    result
  end

  def blank_error
    errors << I18n.t("validators.blank_error")
  end
end
