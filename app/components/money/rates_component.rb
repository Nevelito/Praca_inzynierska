# frozen_string_literal: true

module Money
  class RatesComponent < ViewComponent::Base
    attr_reader :rates

    def initialize(rates:)
      @rates = rates
    end

    private

    def date
      "#{Time.zone.now.strftime('%d')} #{I18n.t('date.month_names')[Time.zone.now.strftime('%m').to_i]} #{Time.zone.now.strftime('%Y')}"
    end
  end
end
