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
      validator = IncomeValidator.new(params)
      validator.validate_data
      if validator.success?
        amount_in_pln = convert_amount_to_pln(params[:income][:amount], params[:income][:currency])
        Income.create!(amount: amount_in_pln,
                       user_id: current_user.id,
                       description: params[:income][:description],
                       date: params[:income][:date])
      else
        @errors = validator.errors
      end
    end

    private

    def convert_amount_to_pln(amount, currency_code)
      if currency_code == 'PLN'
        amount.to_f
      else
        service = NbpApiService.new
        service.convert_to_pln(amount, currency_code)
      end
    end
  end
end
