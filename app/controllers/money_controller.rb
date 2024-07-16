class MoneyController < ApplicationController
  def index
    incomes = current_user.incomes.where(month: current_month, year: current_year)
    spendings = current_user.spendings.where(month: current_month, year: current_year)

    render :index, locals: { incomes:, spendings: }
  end

  private

  def current_month
    Time.zone.now.month
  end

  def current_year
    Time.zone.now.year
  end
end
