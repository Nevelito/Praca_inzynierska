# frozen_string_literal: true

module Modal
  class HeadingComponent < ViewComponent::Base
    attr_reader :text

    def initialize(text:)
      @text = text
    end
  end
end
