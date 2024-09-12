# frozen_string_literal: true

module Goals
  class OptionButtonsComponent < ViewComponent::Base
    def initialize(goal_payment:)
      @goal_payment = goal_payment
    end

    attr_reader :goal_payment
  end
end
