# frozen_string_literal: true

module Money
  module Charts
    class ColumnComponent < ViewComponent::Base
      def initialize(data:, date:, type:)
        @data = data
        @date = date
        @type = type
      end

      def render?
        data.present?
      end


      private

      attr_reader :data, :date, :type
      def period
        case type
        when "daily_spendings"
          "#{I18n.t('date.month_names')[date.strftime('%m').to_i]} #{date.strftime('%Y')}"
        when "daily_incomes"
          "#{I18n.t('date.month_names')[date.strftime('%m').to_i]} #{date.strftime('%Y')}"
        else
          date.strftime('%Y')
        end
      end

      def xtitle
        case type
        when "daily_spendings"
          "Dzień"
        when "daily_incomes"
          "Dzień"
        else
          "Miesiąc"
        end
      end

      def period_text
        case type
        when "daily_spendings"
          "Dzienne wydatki"
        when "daily_incomes"
          "Dzienne przychody"
        when "monthly_spendings"
          "Miesięczne wydatki"
        else
          "Miesięczne przychody"
        end
      end

      def ytitle
        case type
        when "daily_spendings"
          "Wydatki"
        when "monthly_spendings"
          "Wydatki"
        else
          "Przychody"
        end
      end
    end
  end
end
