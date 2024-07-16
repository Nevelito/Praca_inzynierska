# frozen_string_literal: true

class Spendings::ShowComponent < ViewComponent::Base
  def initialize(spendings:)
    @spendings = spendings
  end

  private

  attr_reader :spendings
end
