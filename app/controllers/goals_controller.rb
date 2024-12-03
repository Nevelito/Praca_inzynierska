# frozen_string_literal: true

class GoalsController < ApplicationController
  def new
    render :new, locals: { goal: Goal.new }
  end

  def edit
    render :edit, locals: { goal: }
  end

  def create
    service = Goals::Create.call(params:, current_user:)
    if service.success?
      flash[:success] = I18n.t("flash.goals.add")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def update
    service = Goals::Update.call(params:, current_user:, goal:)
    if service.success?
      flash[:success] = I18n.t("flash.goals.edit")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    if goal
      goal.destroy
      flash[:success] = I18n.t("flash.goals.destoy")
    else
      flash[:alert] = I18n.t("flash.goals.not_existed")
    end
    redirect_back_or_to money_index_path, status: :see_other
  end

  def show
    render :show, locals: { goal:, goal_payments: }
  end

  private

  def goal
    Goal.find(params[:id])
  end

  def goal_payments
    GoalPayment.where(goal_id: goal.id)
  end
end
