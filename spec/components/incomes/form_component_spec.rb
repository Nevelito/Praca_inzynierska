# require "rails_helper"
#
# RSpec.describe Incomes::FormComponent, type: :component do
#   let!(:date) { Time.zone.today }
#   let(:component) { described_class.new(date:) }
#
#   before do
#     render_inline(component)
#   end
#
#   it "rednders correct texts" do
#     expect(page).to have_content I18n.t("incomes.month")
#     expect(page).to have_content I18n.t("incomes.year")
#     expect(page).to have_content I18n.t("incomes.filter")
#   end
#
#   it "rednders correct date" do
#     expect(page).to have_content date.strftime("%Y").to_i
#     expect(page).to have_content I18n.t("date.month_names")[date.strftime("%m").to_i]
#   end
# end
