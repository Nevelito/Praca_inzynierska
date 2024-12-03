# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoalPayments::Create do
  subject(:service) { described_class.new(params:, current_user:) }

  let!(:goal) { create(:goal, user: current_user) }
  let(:current_user) { create(:user) }
  let(:amount) { 300 }
  let(:currency) { "PLN" }
  let(:params) do
    {
      goal_payment: {
        goal_id: goal.id,
        amount:,
        currency:
      }
    }
  end

  context "when params are correct" do
    it "create new goal_payment" do
      expect { service.call }.to change(GoalPayment, :count).by(1)
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "do not create new goal_payment" do
        expect { service.call }.not_to change(GoalPayment, :count)
      end
    end

    context "when invalid goal_id" do
      let(:params) do
        {
          goal_payment: {
            goal_id: goal.id.to_i + 1,
            amount:,
            currency:
          }
        }
      end

      it "do not create new goal_payment" do
        expect { service.call }.not_to change(GoalPayment, :count)
      end
    end
  end
end
