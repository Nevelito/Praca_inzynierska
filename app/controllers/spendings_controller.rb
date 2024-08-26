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
      flash[:success] = 'Wydatek dodany prawidłowo'
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def update
    service = Spendings::Update.call(params:, current_user:, spending:)
    if service.success?
      flash[:success] = 'udało sie edytować wydatek'
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash'), status: :unprocessable_entity
    end
  end

  def destroy
    if spending
      spending.destroy
      flash[:success] = 'udało się usunąć wydatek'
    else
      flash[:alert] = 'dany wydatek nie isnieje'
    end
    redirect_back_or_to money_index_path, status: :see_other
  end

  private

  def spending
    Spending.find(params[:id])
  end
end
