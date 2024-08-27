# frozen_string_literal: true

class GoalPaymentsController < ApplicationController
  def new
    render :new, locals: { goal_payment: GoalPayment.new, goal: }
  end

  def edit
    render :edit, locals: { goal_payment: }
  end

  def create
    service = GoalPayments::Create.call(params:, current_user:)
    if service.success?
      flash[:success] = I18n.t("flash.goal_payments.add")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def update
    service = GoalPayments::Update.call(params:, current_user:, goal_payment:)
    if service.success?
      flash[:success] = I18n.t("flash.goal_payments.edit")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    if goal_payment
      goal_payment.destroy
      flash[:success] = I18n.t("flash.goal_payments.destoy")
    else
      flash[:alert] = I18n.t("flash.goal_payments.not_existed")
    end
    redirect_back_or_to money_index_path, status: :see_other
  end

  private

  def goal_payment
    GoalPayment.find(params[:id])
  end

  def goal
    Goal.find(params[:goal])
  end
end
