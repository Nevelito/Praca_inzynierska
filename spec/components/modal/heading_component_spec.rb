# spec/components/money/form_component_spec.rb

require 'rails_helper'

RSpec.describe Modal::HeadingComponent, type: :component do
  let(:text) { "Testowy" }
  let(:component) { described_class.new(text:) }

  before do
    render_inline(component)
  end

  it 'renders correct text' do
    expect(page).to have_content text
  end
end
