# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoalValidator do
  subject(:validator) { described_class.new(params).validate_data }

  let(:target_amount) { 300 }
  let(:name) { "Nazwa" }
  let(:description) { "Testowy opis" }
  let(:due_date) { Time.zone.tomorrow.to_s }

  let(:params) do
    {
      goal: {
        target_amount:,
        name:,
        description:,
        due_date:
      }
    }
  end

  context "when params are correct" do
    it "passes" do
      expect(validator.success?).to be true
    end
  end

  context "when params are incorrect" do
    context "when invalid target_amount" do
      let(:target_amount) { nil }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.goals.invalid_target_amount"))
      end
    end

    context "when invalid name" do
      let(:name) { "a" * 51 }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.goals.invalid_name"))
      end
    end

    context "when invalid description" do
      let(:description) { "a" * 101 }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.goals.invalid_desription"))
      end
    end

    context "when invalid due_date" do
      let(:due_date) { Time.zone.today }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.goals.invalid_date"))
      end
    end
  end
end
