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
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def update
    service = Incomes::Update.call(params:, current_user:, income:)
    if service.success?
      flash[:success] = I18n.t("flash.incomes.edit")
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
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

  private

  def income
    Income.find(params[:id])
  end
end
