# frozen_string_literal: true

class Income < ApplicationRecord
  attr_accessor :currency

  belongs_to :user
end
