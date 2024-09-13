# frozen_string_literal: true

class CurrencyController < ApplicationController
  def index
    render :index, locals: { currencies:, rates: }
  end

  private

  def currencies
    ['PLN', 'USD', 'EUR', 'GBP', 'CHF', 'AUD', 'CAD', 'CZK', 'DKK', 'JPY', 'NOK', 'SEK', 'HUF', 'RUB', 'CNY']
  end

  def rates
    service = NbpApiService.new
    currencies = %w[USD EUR GBP CHF AUD CAD CZK DKK JPY NOK SEK HUF RUB CNY
                    PLN]
    service.fetch_exchange_rates(currencies)
  end
end
