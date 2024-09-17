# frozen_string_literal: true

require "rails_helper"

describe "Updates spending", :js do
  let(:user) { create(:user) }
  let(:spending) { create(:spending, user:) }
  let(:amount) { "300" }
  let(:data) { "2026-09-20" }
  let(:description) { "Testowy opis" }

  before do
    login_as user
    visit edit_spending_path(spending)

    fill_in "Kwota", with: amount
    fill_in "Data", with: data
    fill_in "Opis", with: description

    click_on "Zapisz"
  end

  context "when user puts correct data" do
    it "updates spending" do
      expect(page).to have_content I18n.t("flash.spendings.edit")
    end
  end

  context "when user puts invalid data" do
    context "when invalid amount" do
      let(:amount) { "" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.spendings.invalid_amount")
      end
    end

    context "when invalid data" do
      let(:data) { "invalid" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.spendings.invalid_date")
      end
    end

    context "when invalid description" do
      let(:description) { "Testowy opis, który jest zbyt długi i pownien zawierać maksymalnie 60 znakóœ" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.spendings.invalid_desription")
      end
    end
  end
end
