require "rails_helper"

RSpec.describe Money::Goals::ShowComponent, type: :component do
  include Support::Mocks::Component
  let!(:goals) { create_list(:goal, 5) }
  let(:component) { described_class.new(goals:) }

  stub_component Money::Goals::DetailComponent, as: :detail_component

  before do
    render_inline(component)
  end

  it "reders detail component for each goal" do
    goals.each do |goal|
      expect(page).to have_rendered(detail_component).with(goal: goal)
    end
  end

  it "rednders correct text" do
    expect(page).to have_content I18n.t("goals.goals")
    expect(page).to have_content I18n.t("goals.add_goal")
    expect(page).to have_content I18n.t("goals.name")
    expect(page).to have_content I18n.t("goals.target_amount")
    expect(page).to have_content I18n.t("goals.options")
  end
end
