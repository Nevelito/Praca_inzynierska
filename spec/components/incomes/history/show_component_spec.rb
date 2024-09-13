require "rails_helper"

RSpec.describe Incomes::History::ShowComponent, type: :component do
  include Support::Mocks::Component
  let!(:incomes) { create_list(:income, 5) }
  let(:component) { described_class.new(incomes:) }

  stub_component Incomes::History::DetailComponent, as: :detail_component

  before do
    render_inline(component)
  end

  it "reders detail component for each income" do
    incomes.each do |income|
      expect(page).to have_rendered(detail_component).with(income: income)
    end
  end

  it "rednders correct text" do
    expect(page).to have_content I18n.t("incomes.incomes")
  end

  it "rednders correct table headings" do
    expect(page).to have_content I18n.t("incomes.amount")
    expect(page).to have_content I18n.t("incomes.description")
    expect(page).to have_content I18n.t("incomes.date")
    expect(page).to have_content I18n.t("incomes.options")
  end
end
