# frozen_string_literal: true

module GoalPayments
  class Create < BaseService
    attr_reader :params, :current_user, :goal_payment

    def initialize(params:, current_user:, goal_payment:)
      @current_user = current_user
      @params = params
      @goal_payment = goal_payment
      @errors = []
    end

    def call
      goal = Goal.find(params[:goal_payment][:goal_id])
      @errors << I18n.t("errors.goal_payments.invalid_goal") if goal.blank?
      validator = GoalPaymentValidator.new(params)
      validator.validate_data
      if validator.success? && @errors.blank?
        goal_payment.update!(amount: params[:goal_payment][:amount],
                         goal_id: goal.id,
                         user_id: current_user.id,
                         date: Time.zone.now.date)
      else
        @errors = validator.errors
      end
    end
  end
end
