require "rails_helper"

RSpec.describe Money::Incomes::ShowComponent, type: :component do
  include Support::Mocks::Component
  let!(:incomes) { create_list(:income, 5) }
  let!(:date) { Time.zone.today }
  let(:incomes_today) { Income.where(date: date).sum(:amount) }
  let(:incomes_this_month) { Income.where(date: date.beginning_of_month..date.end_of_month).sum(:amount) }
  let(:component) { described_class.new(incomes: Income.all, date:) }

  stub_component Money::Incomes::DetailComponent, as: :detail_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(detail_component).with(text: "Dzisiaj:", amount: incomes_today) }
  it { is_expected.to have_rendered(detail_component).with(text: "W tym miesiącu:", amount: incomes_this_month) }

  it "rednders correct text" do
    expect(page).to have_content I18n.t("incomes.incomes")
  end
end
