# frozen_string_literal: true

require "rails_helper"

RSpec.describe Goals::Update do
  subject(:service) { described_class.new(params:, current_user:, goal:) }

  let(:goal) { create(:goal, user: current_user) }
  let(:current_user) { create(:user) }
  let(:target_amount) { 3000 }
  let(:name) { "Nazwa" }
  let(:currency) { "PLN" }
  let(:description) { "Testowy opis" }
  let(:due_date) { Time.zone.tomorrow.to_s }

  let(:params) do
    {
      goal: {
        name:,
        target_amount:,
        currency:,
        description:,
        due_date:
      }
    }
  end

  context "when params are correct" do
    it "update goal target_amount" do
      expect { service.call }.to change { goal.reload.target_amount }.to(target_amount)
    end

    it "update goal name" do
      expect { service.call }.to change { goal.reload.name }.to(name)
    end

    it "update goal description" do
      expect { service.call }.to change { goal.reload.description }.to(description)
    end
  end

  context "when params are incorrect" do
    context "when invalid target_amount" do
      let(:target_amount) { nil }

      it "do not update goal" do
        expect { service.call }.not_to(change { goal.reload.target_amount })
      end
    end

    context "when invalid due_date" do
      let(:due_date) { Time.zone.today }

      it "do not update goal" do
        expect { service.call }.not_to(change { goal.reload.due_date })
      end
    end

    context "when invalid name" do
      let(:name) { "a"*51 }

      it "do not update goal" do
        expect { service.call }.not_to(change { goal.reload.name })
      end
    end

    context "when invalid description" do
      let(:description) { "a"*101 }

      it "do not update goal" do
        expect { service.call }.not_to(change { goal.reload.description })
      end
    end
  end
end
