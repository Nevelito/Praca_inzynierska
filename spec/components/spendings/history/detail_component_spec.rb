require "rails_helper"

RSpec.describe Spendings::History::DetailComponent, type: :component do
  include Support::Mocks::Component
  let!(:spending) { create(:spending, kind: "house") }
  let(:component) { described_class.new(spending:) }

  stub_component Spendings::History::OptionButtonsComponent, as: :option_buttons_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(option_buttons_component).with(spending: spending) }

  it "rednders correct amount" do
    expect(page).to have_content "#{spending.amount} PLN"
  end

  it "rednders correct desription" do
    expect(page).to have_content spending.description
  end

  it "rednders correct kind" do
    expect(page).to have_content "Dom"
  end

  it "rednders correct date" do
    expect(page).to have_content "#{spending.date.strftime("%d")} #{I18n.t("date.month_names")[spending.date.strftime("%m").to_i]} #{spending.date.strftime("%Y")}"
  end
end
