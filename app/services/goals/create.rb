# frozen_string_literal: true

module Goals
  class Create < BaseService
    attr_reader :params, :current_user

    def initialize(params:, current_user:)
      @current_user = current_user
      @params = params
      @errors = []
    end

    def call
      validator = GoalValidator.new(params)
      validator.validate_data
      if validator.success?
        amount_in_pln = convert_amount_to_pln(params[:goal][:target_amount], params[:goal][:currency])
        Goal.create!(target_amount: amount_in_pln,
                         user_id: current_user.id,
                         name: params[:goal][:name],
                         description: params[:goal][:description],
                         due_date: params[:goal][:due_date])
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
