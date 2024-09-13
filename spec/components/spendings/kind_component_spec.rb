# spec/components/money/form_component_spec.rb

require 'rails_helper'

RSpec.describe Spendings::KindComponent, type: :component do
  let(:spendings) { create_list(:spending, 5) }
  let(:kind) { "shopping" }
  let(:component) { described_class.new(spendings: Spending.all, kind:) }

  before do
    render_inline(component)
  end

  it 'renders the form with the correct month and year and kind' do
    expect(page).to have_content "Zakupy"
    expect(page).to have_content "#{Spending.where(kind: "shopping").sum(:amount)} PLN"
  end
end
