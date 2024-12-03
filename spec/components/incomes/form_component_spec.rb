# spec/components/money/form_component_spec.rb

require 'rails_helper'

RSpec.describe Incomes::FormComponent, type: :component do
  let(:date) { Date.today }
  let(:component) { described_class.new(date:) }

  before do
    render_inline(component)
  end

  it 'renders the form with the correct month and year' do
    expect(page).to have_selector('select[name="month"]')
    expect(page).to have_select('month', selected: I18n.t("date.month_names")[date.month])
    expect(page).to have_selector('input[name="year"][value="' + date.year.to_s + '"]')
    expect(page).to have_button(I18n.t("incomes.filter"))
  end
end
