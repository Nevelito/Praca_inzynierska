# frozen_string_literal: true

class Spendings::DetailComponent < ViewComponent::Base
  with_collection_parameter :spending

  def initialize(spending:)
    @spending = spending
  end

  private

  attr_reader :spending
end
