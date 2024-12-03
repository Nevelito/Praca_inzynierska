# frozen_string_literal: true

require "rails_helper"

describe "Create new income", :js do
  let(:user) { create(:user) }
  let(:amount) { "300" }
  let(:data) { "2026-09-20" }
  let(:description) { "Testowy opis" }

  before do
    login_as user
    visit money_index_path
    click_on "Nowy przychód"

    fill_in "Kwota", with: amount
    fill_in "Data", with: data
    fill_in "Opis", with: description

    click_on "Zapisz"
  end

  context "when user puts correct data" do
    it "creates new income" do
      expect(page).to have_content I18n.t("flash.incomes.add")
    end
  end

  context "when user puts invalid data" do
    context "when invalid amount" do
      let(:amount) { "" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.incomes.invalid_amount")
      end
    end

    context "when invalid data" do
      let(:data) { "invalid" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.incomes.invalid_date")
      end
    end

    context "when invalid description" do
      let(:description) { "Testowy opis, który jest zbyt długi i pownien zawierać maksymalnie 60 znakóœ" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.incomes.invalid_desription")
      end
    end
  end
end
