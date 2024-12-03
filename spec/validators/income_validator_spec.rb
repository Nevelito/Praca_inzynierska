# frozen_string_literal: true

require "rails_helper"

RSpec.describe IncomeValidator do
  subject(:validator) { described_class.new(params).validate_data }

  let(:amount) { 300 }
  let(:description) { "Testowy opis" }
  let(:date) { Time.zone.tomorrow.to_s }

  let(:params) do
    {
      income: {
        amount:,
        description:,
        date:
      }
    }
  end

  context "when params are correct" do
    it "passes" do
      expect(validator.success?).to be true
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.incomes.invalid_amount"))
      end
    end

    context "when invalid date" do
      let(:date) { nil }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.incomes.invalid_date"))
      end
    end

    context "when invalid description" do
      let(:description) { "a" * 61 }

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.incomes.invalid_desription"))
      end
    end
  end
end
