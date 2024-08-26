# frozen_string_literal: true

class Spending < ApplicationRecord
  attr_accessor :currency

  belongs_to :user

  enum kind: { house: 'house', car: 'car', healthcare: 'healthcare', entertaiment: 'entertaiment',
               groceries: 'groceries', restaurants: 'restaurant', shopping: 'shopping', other: 'other' }
end
