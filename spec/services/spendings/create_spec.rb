# frozen_string_literal: true

require "rails_helper"

RSpec.describe Spendings::Create do
  subject(:service) { described_class.new(params:, current_user:) }

  let(:current_user) { create(:user) }
  let(:amount) { 300 }
  let(:currency) { "PLN" }
  let(:kind) { "shopping" }
  let(:description) { "Testowy opis" }
  let(:date) { Time.zone.today.to_s }

  let(:params) do
    {
      spending: {
        amount:,
        currency:,
        kind:,
        description:,
        date:
      }
    }
  end

  context "when params are correct" do
    it "create new spending" do
      expect { service.call }.to change(Spending, :count).by(1)
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "do not create new spening" do
        expect { service.call }.not_to change(Spending, :count)
      end
    end

    context "when invalid date" do
      let(:date) { Time.zone.today }

      it "do not create new spening" do
        expect { service.call }.not_to change(Spending, :count)
      end
    end

    context "when invalid kind" do
      let(:kind) { "invalid" }

      it "do not create new spening" do
        expect { service.call }.not_to change(Spending, :count)
      end
    end

    context "when invalid description" do
      let(:description) { "a"*101 }

      it "do not create new spening" do
        expect { service.call }.not_to change(Spending, :count)
      end
    end
  end
end
