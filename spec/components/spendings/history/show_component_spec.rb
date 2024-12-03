require "rails_helper"

RSpec.describe Spendings::History::ShowComponent, type: :component do
  include Support::Mocks::Component
  let!(:spendings) { create_list(:spending, 5) }
  let(:component) { described_class.new(spendings:) }

  stub_component Spendings::History::DetailComponent, as: :detail_component

  before do
    render_inline(component)
  end

  it "reders detail component for each income" do
    spendings.each do |spending|
      expect(page).to have_rendered(detail_component).with(spending: spending)
    end
  end

  it "rednders correct text" do
    expect(page).to have_content I18n.t("spendings.spendings")
  end

  it "rednders correct table headings" do
    expect(page).to have_content I18n.t("spendings.amount")
    expect(page).to have_content I18n.t("spendings.description")
    expect(page).to have_content I18n.t("spendings.date")
    expect(page).to have_content I18n.t("spendings.type")
    expect(page).to have_content I18n.t("spendings.options")
  end
end
