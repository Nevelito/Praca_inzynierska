# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spendings::Update do
  subject(:service) { described_class.new(params:, current_user:, spending:) }

  let(:spending) { create(:spending, kind: "house", date: Time.zone.today.to_s) }
  let(:current_user) { create(:user) }
  let(:amount) { 300 }
  let(:kind) { "shopping" }
  let(:description) { "Testowy opis" }
  let(:date) { "2025-09-13" }

  let(:params) do
    {
      spending: {
        amount:,
        kind:,
        description:,
        date:
      }
    }
  end

  context "when params are correct" do
    it "update spending amount" do
      expect { service.call }.to change { spending.reload.amount }.to(amount)
    end

    it "update spending kind" do
      expect { service.call }.to change { spending.reload.kind }.to(kind)
    end

    it "update spending description" do
      expect { service.call }.to change { spending.reload.description }.to(description)
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "do not update spending" do
        expect { service.call }.not_to(change { spending.reload.amount })
      end
    end

    context "when invalid date" do
      let(:date) { Time.zone.today }

      it "do not update spending" do
        expect { service.call }.not_to(change { spending.reload.date })
      end
    end

    context "when invalid kind" do
      let(:kind) { "invalid" }

      it "do not update spending" do
        expect { service.call }.not_to(change { spending.reload.kind })
      end
    end

    context "when invalid description" do
      let(:description) { "a"*101 }

      it "do not update spending" do
        expect { service.call }.not_to(change { spending.reload.description })
      end
    end
  end
end
