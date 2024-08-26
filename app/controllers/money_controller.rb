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
      spendings_by_month:,
      spendings_by_day:,
      rates:
    }
  end

  private

  def overall_balance
    incomes = current_user.incomes
    spendings = current_user.spendings
    balance(incomes:, spendings:)
  end

  def monthly_balance
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    spendings = current_user.spendings.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
    balance(incomes:, spendings:)
  end

  def yearly_balance
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
    spendings = current_user.spendings.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
    balance(incomes:, spendings:)
  end

  def balance(incomes:, spendings:)
    total_incomes = incomes.sum(:amount)
    total_spendings = spendings.sum(:amount)
    total_incomes - total_spendings
  end

  def spendings_by_month
    Spending.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
            .group('EXTRACT(MONTH FROM date)')
            .sum(:amount)
  end

  def spendings_by_day
    Spending.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
            .group('EXTRACT(DAY FROM date)')
            .sum(:amount)
  end

  def rates
    service = NbpApiService.new
    currencies = %w[USD EUR GBP CHF AUD CAD CZK DKK JPY NOK SEK HUF RUB CNY
                    PLN]
    service.fetch_exchange_rates(currencies)
  end
end
