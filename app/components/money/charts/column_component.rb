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
          I18n.t("charts.day")
        when "daily_incomes"
          I18n.t("charts.day")
        else
          I18n.t("charts.month")
        end
      end

      def period_text
        case type
        when "daily_spendings"
          I18n.t("charts.daily_spendings")
        when "daily_incomes"
          I18n.t("charts.daily_incomes")
        when "monthly_spendings"
          I18n.t("charts.monthly_spendings")
        else
          I18n.t("charts.monthly_incomes")
        end
      end

      def ytitle
        case type
        when "daily_spendings"
          I18n.t("charts.spendings")
        when "monthly_spendings"
          I18n.t("charts.spendings")
        else
          I18n.t("charts.incomes")
        end
      end
    end
  end
end
