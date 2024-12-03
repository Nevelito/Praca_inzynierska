# frozen_string_literal: true

require "rails_helper"

RSpec.describe Goals::Create do
  subject(:service) { described_class.new(params:, current_user:) }

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
    it "create new goal" do
      expect { service.call }.to change(Goal, :count).by(1)
    end
  end

  context "when params are incorrect" do
    context "when invalid target_amount" do
      let(:target_amount) { nil }

      it "do not create new goal" do
        expect { service.call }.not_to change(Goal, :count)
      end
    end

    context "when invalid due_date" do
      let(:due_date) { Time.zone.today }

      it "do not create new goal" do
        expect { service.call }.not_to change(Goal, :count)
      end
    end

    context "when invalid description" do
      let(:description) { "a" * 101 }

      it "do not create new goal" do
        expect { service.call }.not_to change(Goal, :count)
      end
    end

    context "when invalid name" do
      let(:name) { "a" * 51 }

      it "do not create new goal" do
        expect { service.call }.not_to change(Goal, :count)
      end
    end
  end
end
