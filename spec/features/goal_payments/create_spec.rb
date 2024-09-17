# frozen_string_literal: true

require "rails_helper"

describe "Create new goal payment", :js do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user:) }
  let(:amount) { "300" }

  before do
    login_as user
    visit goal_path(goal)
    click_on "Zasil cel"

    fill_in "Kwota", with: amount

    click_on "Zapisz"
  end

  context "when user puts correct data" do
    it "creates new goal_payment" do
      expect(page).to have_content I18n.t("flash.goal_payments.add")
    end
  end

  context "when user puts invalid data" do
    context "when invalid amount" do
      let(:amount) { "" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.goal_payments.invalid_amount")
      end
    end
  end
end
