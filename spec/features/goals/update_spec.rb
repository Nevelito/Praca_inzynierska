# frozen_string_literal: true

require "rails_helper"

describe "Update goal", :js do
  let(:user) { create(:user) }
  let(:goal) { create(:goal, user:) }
  let(:target_amount) { "300" }
  let(:name) { "Testowa Nazwa" }
  let(:date) { "2026-09-20" }
  let(:description) { "Testowy opis" }

  before do
    login_as user
    visit edit_goal_path(goal)

    fill_in "Nazwa", with: name
    fill_in "Cel", with: target_amount
    fill_in "Termin", with: date
    fill_in "Opis", with: description

    click_on "Zapisz"
  end

  context "when user puts correct data" do
    it "updates goal" do
      expect(page).to have_content I18n.t("flash.goals.edit")
    end
  end

  context "when user puts invalid data" do
    context "when invalid target_amount" do
      let(:target_amount) { "" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.goals.invalid_target_amount")
      end
    end

    context "when invalid date" do
      let(:date) { "invalid" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.goals.invalid_date")
      end
    end

    context "when invalid name" do
      let(:name) { "Testowa nazwa, która jest za długa i ma ponad 50 lister" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.goals.invalid_name")
      end
    end

    context "when invalid description" do
      let(:description) { "a" * 101 }

      it "shows correct error" do
        expect(page).to have_content I18n.t("errors.incomes.invalid_desription")
      end
    end
  end
end
