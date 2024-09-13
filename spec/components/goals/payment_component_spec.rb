require "rails_helper"

RSpec.describe Goals::PaymentComponent, type: :component do
  include Support::Mocks::Component

  let(:goal_payment) { create(:goal_payment) }
  let(:component) { described_class.new(goal_payment:) }

  stub_component Goals::OptionButtonsComponent, as: :option_buttons_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(option_buttons_component).with(goal_payment: goal_payment) }

  it "rednders correct amount" do
    expect(page).to have_content "#{goal_payment.amount} PLN"
  end

  it "rednders correct date" do
    expect(page).to have_content "#{goal_payment.payment_date.strftime("%d")} #{I18n.t("date.month_names")[goal_payment.payment_date.strftime("%m").to_i]} #{goal_payment.payment_date.strftime("%Y")}"
  end
end
