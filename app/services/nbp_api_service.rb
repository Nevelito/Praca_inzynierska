# frozen_string_literal: true

class NbpApiService
  include HTTParty
  base_uri 'http://api.nbp.pl/api'

  def initialize
    @options = { headers: { 'Accept' => 'application/json' } }
  end

  def fetch_exchange_rate(currency_code)
    response = self.class.get("/exchangerates/rates/A/#{currency_code}/?format=json", @options)
    raise "API request failed with code #{response.code}" unless response.success?

    response.parsed_response
  end

  def fetch_exchange_rates(currencies)
    response = self.class.get('/exchangerates/tables/A/?format=json', @options)
    raise "API request failed with code #{response.code}" unless response.success?

    parse_rates(response.parsed_response, currencies)
  end

  def convert_to_pln(amount, currency_code)
    rate_data = fetch_exchange_rate(currency_code)
    rate = rate_data['rates'].first['mid']
    (amount.to_f * rate).round(2)
  end

  def convert_currency(amount, from_currency, to_currency)
    if from_currency == 'PLN'
      amount_in_pln = amount
    else
      amount_in_pln = convert_to_pln(amount, from_currency)
    end

    if to_currency == 'PLN'
      amount_in_pln.round(2)
    else
      rate_data = fetch_exchange_rate(to_currency)
      rate = rate_data['rates'].first['mid']
      (amount_in_pln / rate).round(2)
    end
  end

  private

  def parse_rates(response_data, currencies)
    rates = response_data.first['rates']
    selected_rates = rates.select { |rate| currencies.include?(rate['code']) }

    selected_rates << { 'code' => 'PLN', 'mid' => 1.0 }
    selected_rates
  end
end
