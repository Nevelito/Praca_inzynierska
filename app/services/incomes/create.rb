# frozen_string_literal: true

module Incomes
  class Create < BaseService
    attr_reader :params, :current_user

    def initialize(params:, current_user:)
      @current_user = current_user
      @params = params
      @errors = []
    end

    def call
      validator = IncomeValidator.new(params: params)
      validator.validate_data
      if validator.success?
        Income.create!(amount: params[:amount],
                       user_id: current_user.id,
                       month: params[:month],
                       year: params[:year]
        )
      else
        @errors = validator.errors
      end
    end
  end
end
