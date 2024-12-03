# frozen_string_literal: true

require "rails_helper"

RSpec.describe Incomes::Update do
  subject(:service) { described_class.new(params:, current_user:, income:) }

  let(:income) { create(:income) }
  let(:current_user) { create(:user) }
  let(:amount) { 300 }
  let(:description) { "Testowy opis" }
  let(:date) { "2025-09-13" }

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
    it "update income amount" do
      expect { service.call }.to change { income.reload.amount }.to(amount)
    end

    it "update income description" do
      expect { service.call }.to change { income.reload.description }.to(description)
    end
  end

  context "when params are incorrect" do
    context "when invalid amount" do
      let(:amount) { nil }

      it "do not update spening" do
        expect { service.call }.not_to(change { income.reload.amount })
      end
    end

    context "when invalid date" do
      let(:date) { Time.zone.today }

      it "do not update spening" do
        expect { service.call }.not_to(change { income.reload.date })
      end
    end

    context "when invalid description" do
      let(:description) { "a" * 101 }

      it "do not update spening" do
        expect { service.call }.not_to(change { income.reload.description })
      end
    end
  end
end
