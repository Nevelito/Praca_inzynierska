# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoalPaymentValidator do
  subject(:validator) { described_class.new(params).validate_data }

  let(:amount) { 300 }
  let(:goal) { create(:goal) }

  let(:params) do
    {
      goal_payment: {
        goal_id: goal.id,
        amount:
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
        expect(validator.errors).to include(I18n.t("errors.goal_payments.invalid_amount"))
      end
    end

    context "when invalid goal_id" do
      let(:params) do
        {
          goal_payment: {
            goal_id: goal.id.to_i + 1,
            amount:
          }
        }
      end

      it "shows correct error" do
        expect(validator.errors).to include(I18n.t("errors.goal_payments.invalid_goal"))
      end
    end
  end
end
