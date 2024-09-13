# frozen_string_literal: true

module Incomes
  class Update < BaseService
    attr_reader :params, :current_user, :income

    def initialize(params:, current_user:, income:)
      @current_user = current_user
      @params = params
      @income = income
      @errors = []
    end

    def call
      validator = IncomeValidator.new(params)
      validator.validate_data
      if validator.success?
        income.update!(amount: params[:income][:amount],
                       description: params[:income][:description],
                       date: params[:income][:date])
      else
        @errors = validator.errors
      end
    end
  end
end
