require "rails_helper"

RSpec.describe Money::Spendings::ShowComponent, type: :component do
  include Support::Mocks::Component
  let!(:spendings) { create_list(:spending, 5) }
  let!(:date) { Time.zone.today }
  let(:spendings_today) { Spending.where(date: date).sum(:amount) }
  let(:spendings_this_month) { Spending.where(date: date.beginning_of_month..date.end_of_month).sum(:amount) }
  let(:component) { described_class.new(spendings: Spending.all, date:) }

  stub_component Money::Spendings::DetailComponent, as: :detail_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(detail_component).with(text: "Dzisiaj", amount: spendings_today) }
  it { is_expected.to have_rendered(detail_component).with(text: "W tym miesiącu", amount: spendings_this_month) }

  it "rednders correct text" do
    expect(page).to have_content I18n.t("spendings.spendings")
  end
end
