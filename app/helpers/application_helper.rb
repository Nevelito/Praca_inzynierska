# frozen_string_literal: true

module ApplicationHelper

  def check_if_active(controllers)
    "border-x-2 border-t-2 border-t-blue-700 border-x-blue-700 rounded-t-lg bg-neutral-500" if controllers.any?(params[:controller])
  end
end
