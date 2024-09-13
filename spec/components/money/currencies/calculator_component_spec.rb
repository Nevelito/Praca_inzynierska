# spec/components/money/currencies/calculator_component_spec.rb

require 'rails_helper'

RSpec.describe Money::Currencies::CalculatorComponent, type: :component do
  let(:currencies) { ['USD', 'EUR', 'PLN', 'GBP'] }
  let(:component) { described_class.new(currencies:) }

  before do
    render_inline(component)
  end

  it 'renders the currency calculator with correct selectors' do
    expect(page).to have_selector('input#amount[type="number"][data-currency-target="amount"]')
    expect(page).to have_selector('select#from_currency[data-currency-target="fromCurrency"]')
    currencies.each do |currency|
      expect(page).to have_select('from_currency', with_options: [currency])
    end
    expect(page).to have_selector('select#to_currency[data-currency-target="toCurrency"]')
    currencies.each do |currency|
      expect(page).to have_select('to_currency', with_options: [currency])
    end
    expect(page).to have_selector('div#result[data-currency-target="result"]')
  end

  it 'renders correct text' do
    expect(page).to have_content I18n.t("currencies.calculator")
    expect(page).to have_content I18n.t("currencies.count")
  end
end
