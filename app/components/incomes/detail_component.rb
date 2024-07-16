# frozen_string_literal: true

class Incomes::DetailComponent < ViewComponent::Base
  with_collection_parameter :income

  def initialize(income:)
    @income = income
  end

  private

  attr_reader :income
end
