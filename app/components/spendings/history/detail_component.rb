# frozen_string_literal: true

module Spendings
  module History
    class DetailComponent < ViewComponent::Base
      with_collection_parameter :spending

      def initialize(spending:)
        @spending = spending
      end

      private

      attr_reader :spending

      def date
        spending.date
      end

      def kind
        case spending.kind
        when 'house'
          'Dom'
        when 'car'
          'Samochód'
        when 'healthcare'
          'Zdrowie'
        when 'entertaiment'
          'Rozrywka'
        when 'groceries'
          'Artykuły spożywcze'
        when 'restaurant'
          'Restauracja'
        when 'shopping'
          'Zakupy'
        else
          'Inne'
        end
      end
    end
  end
end
