require "rails_helper"

RSpec.describe Money::Goals::DetailComponent, type: :component do
  include Support::Mocks::Component
  let(:goal) { create(:goal) }
  let!(:goal_payments) { create_list(:goal_payment, 5, goal: goal) }
  let(:component) { described_class.new(goal:) }

  stub_component Money::Goals::OptionButtonsComponent, as: :option_buttons_component

  before do
    render_inline(component)
  end

  it { is_expected.to have_rendered(option_buttons_component).with(goal: goal) }

  it "rednders correct text" do
    expect(page).to have_content I18n.t("goals.add_money_to_goal")
    expect(page).to have_content goal.name
    expect(page).to have_content "#{GoalPayment.sum(:amount)} PLN / #{goal.target_amount} PLN"
  end
end
