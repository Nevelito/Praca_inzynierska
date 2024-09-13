# frozen_string_literal: true

module Spendings
  class AllCategoryComponent < ViewComponent::Base
    attr_reader :spendings

    def initialize(spendings:)
      @spendings = spendings
    end
  end
end
