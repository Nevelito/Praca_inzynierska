require "rails_helper"

RSpec.describe Goals::HeadingComponent, type: :component do
  let(:goal) { create(:goal) }
  let!(:goal_payments) { create_list(:goal_payment, 5, goal: goal) }
  let(:component) { described_class.new(goal:, goal_payments:) }

  before do
    render_inline(component)
  end

  it "rednders correct name" do
    expect(page).to have_content goal.name
  end

  it "rednders correct due_date" do
    expect(page).to have_content "#{I18n.t("goals.due_date_2")} #{goal.due_date.strftime("%d.%m.%Y")}"
  end

  it "rednders correct description" do
    expect(page).to have_content I18n.t("goals.description_2")
    expect(page).to have_content goal.description
  end

  it "rednders correct money" do
    expect(page).to have_content I18n.t("goals.earn_money")
    expect(page).to have_content "#{goal_payments.sum(&:amount)}PLN / #{goal.target_amount}PLN"
  end

  it "rednders correct table headings" do
    expect(page).to have_content I18n.t("goal_payments.amount")
    expect(page).to have_content I18n.t("goal_payments.payment_date")
    expect(page).to have_content I18n.t("goal_payments.options")
  end
end
