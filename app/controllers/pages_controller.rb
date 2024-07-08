# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]

  def home
    render 'pages/home'
  end
end
