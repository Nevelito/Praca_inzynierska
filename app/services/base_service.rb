# frozen_string_literal: true

class BaseService
  include Pundit::Authorization
  attr_reader :errors

  def self.call(**args)
    new(**args).tap(&:call)
  end

  def success?
    errors.blank?
  end

  def failure?
    !success?
  end
end
