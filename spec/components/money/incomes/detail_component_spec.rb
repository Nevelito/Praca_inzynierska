require "rails_helper"

RSpec.describe Money::Incomes::DetailComponent, type: :component do
  let!(:text) { "Testowy tekst" }
  let!(:amount) { 1234 }
  let(:component) { described_class.new(text:, amount:) }

  before do
    render_inline(component)
  end

  it "rednders correct texts" do
    expect(page).to have_content text
  end

  it "rednders correct date" do
    expect(page).to have_content "#{amount} PLN"
  end
end
