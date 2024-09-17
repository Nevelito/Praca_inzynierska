# frozen_string_literal: true

module Spendings
  module Charts
    class PieComponent < ViewComponent::Base
      attr_reader :spendings

      def initialize(spendings:)
        @spendings = spendings
      end

      def render?
        spendings.present?
      end

      private

      def translated_spendings
        spendings.group(:kind).sum(:amount).transform_keys do |key|
        {
          "house" => "Dom",
          "car" => "Samochód",
          "healthcare" => "Zdrowie",
          "entertaiment" => "Rozrywka",
          "groceries" => "Artykuły spożywcze",
          "restaurants" => "Restauracja",
          "shopping" => "Zakupy",
          "other" => "Inne"
        }[key] || key
        end
      end
    end
  end
end
