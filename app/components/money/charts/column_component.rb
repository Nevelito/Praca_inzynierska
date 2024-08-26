# frozen_string_literal: true

module Money
  module Charts
    class ColumnComponent < ViewComponent::Base
      def initialize(data:, date:, type:)
        @data = data
        @date = date
        @type = type
      end

      private

      attr_reader :data, :date, :type

      def period
        type == 'daily' ? I18n.t('date.month_names')[date.strftime('%m').to_i] : date.strftime('%Y')
      end

      def xtitle
        type == 'daily' ? 'Dzień' : 'Miesiąc'
      end

      def period_text
        type == 'daily' ? 'Dzienne' : 'Miesięczne'
      end
    end
  end
end
