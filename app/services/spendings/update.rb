# frozen_string_literal: true

module Spendings
  class Update < BaseService
    attr_reader :params, :current_user, :spending

    def initialize(params:, current_user:, spending:)
      @current_user = current_user
      @params = params
      @spending = spending
      @errors = []
    end

    def call
      validator = SpendingValidator.new(params)
      validator.validate_data
      if validator.success?
        spending.update!(amount: params[:spending][:amount],
                         kind: params[:spending][:kind],
                         description: params[:spending][:description],
                         date: params[:spending][:date])
      else
        @errors = validator.errors
      end
    end
  end
end
