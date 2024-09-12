# frozen_string_literal: true

module Spendings
  class FormComponent < ViewComponent::Base
    attr_reader :date, :kind

    def initialize(date:, kind:)
      @date = date
      @kind = kind
    end
  end
end
