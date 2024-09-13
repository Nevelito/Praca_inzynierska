# frozen_string_literal: true

module Goals
  class Update < BaseService
    attr_reader :params, :current_user, :goal

    def initialize(params:, current_user:, goal:)
      @current_user = current_user
      @params = params
      @goal = goal
      @errors = []
    end

    def call
      validator = GoalValidator.new(params)
      validator.validate_data
      if validator.success?
        goal.update!(target_amount: params[:goal][:target_amount],
                         user_id: current_user.id,
                         name: params[:goal][:name],
                         description: params[:goal][:description],
                         due_date: params[:goal][:due_date])
      else
        @errors = validator.errors
      end
    end
  end
end
