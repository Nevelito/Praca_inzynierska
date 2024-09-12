# frozen_string_literal: true

class MoneyController < ApplicationController
  def index
    @selected_date = if params[:month] && params[:year]
                       Date.new(params[:year].to_i, params[:month].to_i, 1)
                     else
                       Time.zone.today
                     end
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    spendings = current_user.spendings.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)

    render :index, locals: {
      incomes:,
      spendings:,
      selected_date: @selected_date,
      overall_balance:,
      monthly_balance:,
      yearly_balance:,
      rates:,
      goals:
    }
  end

  private

  def overall_balance
    incomes = current_user.incomes
    spendings = current_user.spendings
    goal_payments = current_user.goal_payments
    balance(incomes:, spendings:, goal_payments:)
  end

  def monthly_balance
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    spendings = current_user.spendings.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    goal_payments = current_user.goal_payments.where(payment_date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    balance(incomes:, spendings:, goal_payments:)
  end

  def yearly_balance
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
    spendings = current_user.spendings.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
    goal_payments = current_user.goal_payments.where(payment_date: @selected_date.beginning_of_year..@selected_date.end_of_year)
    balance(incomes:, spendings:, goal_payments:)
  end

  def balance(incomes:, spendings:, goal_payments:)
    total_incomes = incomes.sum(:amount)
    total_spendings = spendings.sum(:amount)
    total_goal_payments = goal_payments.sum(:amount)
    total_incomes - total_spendings - total_goal_payments
  end

  def rates
    service = NbpApiService.new
    currencies = %w[USD EUR GBP CHF AUD CAD CZK DKK JPY NOK SEK HUF RUB CNY
                    PLN]
    service.fetch_exchange_rates(currencies)
  end

  def goals
    Goal.where(user_id: current_user.id)
  end
end
