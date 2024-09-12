require "rails_helper"

RSpec.describe Incomes::History::DetailComponent, type: :component do
  include Support::Mocks::Component
  let!(:income) { create(:income) }
  let(:component) { described_class.new(income:) }

  stub_component Incomes::History::OptionButtonsComponent, as: :option_buttons_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(option_buttons_component).with(income: income) }

  it "rednders correct amount" do
    expect(page).to have_content "#{income.amount} PLN"
  end

  it "rednders correct desription" do
    expect(page).to have_content income.description
  end

  it "rednders correct date" do
    expect(page).to have_content "#{income.date.strftime("%d")} #{I18n.t("date.month_names")[income.date.strftime("%m").to_i]} #{income.date.strftime("%Y")}"
  end
end
