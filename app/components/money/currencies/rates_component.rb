# frozen_string_literal: true

module Money
  module Currencies
    class RatesComponent < ViewComponent::Base
      attr_reader :rates, :home_site

      def initialize(rates:, home_site:)
        @rates = rates
        @home_site = home_site
      end

      private

      def date
        "#{Time.zone.now.strftime('%d')} #{I18n.t('date.month_names')[Time.zone.now.strftime('%m').to_i]} #{Time.zone.now.strftime('%Y')}"
      end
    end
  end
end
