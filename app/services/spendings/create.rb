# frozen_string_literal: true

module Spendings
  class Create < BaseService
    attr_reader :params, :current_user

    def initialize(params:, current_user:)
      @current_user = current_user
      @params = params
      @errors = []
    end

    def call
      validator = SpendingValidator.new(params)
      validator.validate_data
      if validator.success?
        Spending.create!(amount: params[:spending][:amount],
                       user_id: current_user.id,
                       kind: params[:spending][:kind],
                       month: params[:spending][:month],
                       year: params[:spending][:year]
        )
      else
        @errors = validator.errors
      end
    end
  end
end
