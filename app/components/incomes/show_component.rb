# frozen_string_literal: true

class Incomes::ShowComponent < ViewComponent::Base

  def initialize(incomes:)
    @incomes = incomes
  end

  private

  attr_reader :incomes
end
