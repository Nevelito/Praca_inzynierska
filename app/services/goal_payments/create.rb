# frozen_string_literal: true

module GoalPayments
  class Create < BaseService
    attr_reader :params, :current_user

    def initialize(params:, current_user:)
      @current_user = current_user
      @params = params
      @errors = []
    end

    def call
      validator = GoalPaymentValidator.new(params)
      validator.validate_data
      if validator.success?
        amount_in_pln = convert_amount_to_pln(params[:goal_payment][:amount], params[:goal_payment][:currency])
        GoalPayment.create!(amount: amount_in_pln,
                         goal_id: validator.goal_id,
                         user_id: current_user.id,
                         payment_date: Time.zone.today)
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
