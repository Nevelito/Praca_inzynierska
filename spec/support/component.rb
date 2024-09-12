# frozen_string_literal: true

require "view_component/test_helpers"
require "capybara/rspec"

module Support
  module Component
    extend ActiveSupport::Concern
    extend RSpec::Matchers::DSL

    included do
      subject do
        defined?(current_user) ? nil : render_inline(component)
        page
      end

      let(:component) do
        described_class.new(
          *(defined?(args) ? args : []),
          **(defined?(kwargs) ? kwargs : { })
        )
      end

      before do
        defined?(controller_params) ? vc_test_controller.request.params.merge!(controller_params) : nil
      end
    end

    matcher :be_rendered do
      match do |_actual|
        expect(component).to be_render
      end
    end

    RSpec.configure do |rspec|
      rspec.include self, type: :component
      rspec.include ViewComponent::TestHelpers, type: :component
      rspec.include Capybara::RSpecMatchers, type: :component

      rspec.define_derived_metadata(file_path: %r{/spec/views/components}) do |metadata|
        metadata[:type] = :component
      end
    end
  end
end
