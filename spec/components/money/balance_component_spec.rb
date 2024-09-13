require "rails_helper"

RSpec.describe Money::BalanceComponent, type: :component do
  let!(:text) { "Testowy tekst" }
  let!(:balance) { 1234 }
  let(:component) { described_class.new(text:, balance:) }

  before do
    render_inline(component)
  end

  it "rednders correct texts" do
    expect(page).to have_content text
  end

  it "rednders correct date" do
    expect(page).to have_content "#{balance} PLN"
  end
end
