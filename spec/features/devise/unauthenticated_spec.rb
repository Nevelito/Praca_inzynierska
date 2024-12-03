# frozen_string_literal: true

require "rails_helper"

describe "Log in", :js do

  before do
    visit root_path

    click_on "Zacznij Teraz"
  end

  it "shows correct error that user must be loged in" do
    expect(page).to have_content I18n.t("devise.failure.user.unauthenticated")
  end
end
