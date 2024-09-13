# frozen_string_literal: true

module Money
  class FormComponent < ViewComponent::Base
    attr_reader :date

    def initialize(date:)
      @date = date
    end
  end
end
