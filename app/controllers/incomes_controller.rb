# frozen_string_literal: true

class IncomesController < ApplicationController
  def new
    render :new, locals: { income: Income.new }
  end

  def edit
    render :edit, locals: { income: }
  end

  def create
    service = Incomes::Create.call(params:, current_user:)
    if service.success?
      flash[:success] = I18n.t("flash.incomes.add")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def update
    service = Incomes::Update.call(params:, current_user:, income:)
    if service.success?
      flash[:success] = I18n.t("flash.incomes.edit")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    if income
      income.destroy
      flash[:success] = I18n.t("flash.incomes.destoy")
    else
      flash[:alert] = I18n.t("flash.incomes.not_existed")
    end
    redirect_back_or_to money_index_path, status: :see_other
  end

  def index
    @selected_date = if params[:month] && params[:year]
                       Date.new(params[:year].to_i, params[:month].to_i, 1)
                     elsif params[:selected_date].present?
                       Date.parse(params[:selected_date])
                     else
                       Time.zone.today
                     end
    incomes = current_user.incomes.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)

    render :index, locals: {
      incomes:,
      selected_date: @selected_date,
      incomes_by_month:,
      incomes_by_day:
    }
  end

  private

  def income
    Income.find(params[:id])
  end

  def incomes_by_month
    Income.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year)
            .group('EXTRACT(MONTH FROM date)')
            .sum(:amount)
  end

  def incomes_by_day
    Income.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)
            .group('EXTRACT(DAY FROM date)')
            .sum(:amount)
  end
end
