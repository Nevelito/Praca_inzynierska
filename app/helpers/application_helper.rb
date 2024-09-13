# frozen_string_literal: true

module ApplicationHelper
  def check_if_active(controllers)
    return unless controllers.any?(params[:controller])

    'border-x-2 border-t-2 border-t-blue-700 border-x-blue-700 rounded-t-lg bg-neutral-500'
  end
end
