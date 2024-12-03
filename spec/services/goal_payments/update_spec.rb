# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoalPayments::Update do
  subject(:service) { described_class.new(params:, current_user:, goal_payment:) }

  let(:goal_payment) { create(:goal_payment, user: current_user) }
  let!(:goal) { create(:goal, user: current_user) }
  let(:current_user) { create(:user) }
  let(:amount) { 300 }
  let(:params) do
    {
      goal_payment: {
        goal_id: goal.id,
        amount:
      }
    }
  end

  context "when params are correct" do
    it "update goal_payment amount" do
      expect { service.call }.to change { goal_payment.reload.amount }.to(amount)
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "do not update goal_payment" do
        expect { service.call }.not_to(change { goal_payment.reload.amount })
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

      it "do not update goal_payment" do
        expect { service.call }.not_to(change { goal_payment.reload.goal_id })
      end
    end
  end
end
