# frozen_string_literal: true

module Spendings
  class KindComponent < ViewComponent::Base
    attr_reader :spendings, :kind

    def initialize(spendings:, kind:)
      @spendings = spendings
      @kind = kind
    end

    private

    def amount
      if kind == "all"
        spendings.sum(:amount)
      else
        spendings.where(kind: kind).sum(:amount)
      end
    end

    def kind_name
      case kind
      when 'all'
        'Wszystkie'
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
