# frozen_string_literal: true

class SpendingsController < ApplicationController
  def new
    render :new, locals: { spending: Spending.new }
  end

  def edit
    render :edit, locals: { spending: }
  end

  def create
    service = Spendings::Create.call(params:, current_user:)
    if service.success?
      flash[:success] = I18n.t("flash.spendings.add")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :see_other
    end
  end

  def update
    service = Spendings::Update.call(params:, current_user:, spending:)
    if service.success?
      flash[:success] = I18n.t("flash.spendings.edit")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.join(' ')
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    if spending
      spending.destroy
      flash[:success] = I18n.t("flash.spendings.destoy")
    else
      flash[:alert] = I18n.t("flash.spendings.not_existed")
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
    @kind = if params[:kind].present?
              params[:kind]
            else
              "all"
            end
    @spendings = current_user.spendings.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month)

    render :index, locals: {
      spendings: @spendings,
      selected_date: @selected_date,
      spendings_by_month:,
      spendings_by_day:,
      filtered_spendings:
    }
  end

  private

  def spending
    Spending.find(params[:id])
  end

  def spendings_by_month
    Spending.where(date: @selected_date.beginning_of_year..@selected_date.end_of_year, user: current_user)
            .group('EXTRACT(MONTH FROM date)')
            .sum(:amount)
  end

  def spendings_by_day
    Spending.where(date: @selected_date.beginning_of_month..@selected_date.end_of_month, user: current_user)
            .group('EXTRACT(DAY FROM date)')
            .sum(:amount)
  end

  def filtered_spendings
    if @kind == "all"
      @spendings
    else
      @spendings.where(kind: @kind)
    end
  end
end
