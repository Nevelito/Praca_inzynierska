# frozen_string_literal: true

require "rails_helper"

describe "Log in", :js do
  let!(:user) { create(:user, email:, password:) }
  let(:email) { "example@examle.com" }
  let(:input_email) { "example@examle.com" }
  let(:password) { "example123" }
  let(:input_password) { "example123" }

  before do
    visit new_user_session_path

    fill_in "E-mail", with: input_email
    fill_in "Hasło", with: input_password

    click_on "Zaloguj się"
  end

  context "when user puts correct data" do
    it "log in correctly" do
      expect(page).to have_content I18n.t("devise.sessions.user.signed_in")
    end
  end

  context "when user puts invalid data" do
    context "when invalid email or password" do
      let(:input_password) { "invalid123" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("devise.failure.user.invalid")
      end
    end

    context "when invalid email" do
      let(:input_email) { "invalid@example.com" }

      it "shows correct error" do
        expect(page).to have_content I18n.t("devise.failure.user.not_found_in_database")
      end
    end
  end
end
