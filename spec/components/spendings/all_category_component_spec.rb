# spec/components/money/form_component_spec.rb

require 'rails_helper'

RSpec.describe Spendings::AllCategoryComponent, type: :component do
  include Support::Mocks::Component
  let(:spendings) { create_list(:spending, 5) }
  let!(:kinds) { ['all', 'house', 'car', 'healthcare', 'entertaiment', 'groceries', 'restaurant', 'shopping', 'other'] }
  let(:component) { described_class.new(spendings:) }

  stub_component Spendings::KindComponent, as: :kind_component

  before do
    render_inline(component)
  end

  it 'renders every kind component' do
    kinds.each do |kind|
      expect(page).to have_rendered(kind_component).with(kind: kind, spendings: spendings)
    end
  end

  it 'renders correct text' do
    expect(page).to have_content "Wydatki podzielone na kategorie"
  end
end
