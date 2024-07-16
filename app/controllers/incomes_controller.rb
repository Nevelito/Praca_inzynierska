class IncomesController < ApplicationController
  def new
    render :new, locals: { income: Income.new }
  end

  def create
    service = Incomes::Create.call(params:, current_user:)
    if service.success?
      flash[:success] = "przychód dodany prawidłowo"
      redirect_back_or_to money_index_path, status: :see_other
    else
      flash.now[:alert] = service.errors.flatten
      render turbo_stream: turbo_stream.update("flash", partial: "layouts/flash"), status: :unprocessable_entity
    end
  end
end
