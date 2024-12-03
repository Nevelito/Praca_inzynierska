# frozen_string_literal: true

require "rails_helper"

describe "Update goal payment", :js do
  let(:user) { create(:user) }
  let(:goal_payment) { create(:goal_payment, user:) }
  let(:amount) { "300" }

  before do
    login_as user
    visit edit_goal_payment_path(goal_payment)

    fill_in "Kwota", with: amount

    click_on "Zapisz"
  end

  context "when user puts correct data" do
    it "updates goal_payment" do
      expect(page).to have_content I18n.t("flash.goal_payments.edit")
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
