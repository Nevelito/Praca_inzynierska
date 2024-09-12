module Support::Mocks
  module Component
    extend ActiveSupport::Concern
    extend RSpec::Matchers::DSL

    module ClassMethods
      def stub_component(component_class, as: nil)
        before do
          allow(component_class).to receive(:new).and_wrap_original do |original, args, **keywords, &block|
            stub = if args
                     original.call(args, **keywords, &block)
                   else
                     original.call(**keywords, &block)
                   end
            component_stubs[component_class.name] = stub
            stub
          end
        end

        return unless as
        let(as) { component_class.name }

        # rubocop:disable RSpec/AnyInstance
        before do
          allow_any_instance_of(component_class).to receive(:render_in).and_wrap_original do |original, *args, &block|
            component_params = original.receiver.method(:initialize).parameters.pluck(1)
            if component_stubs[component_class.to_s]
              render_params = component_params.map { |param| { param => original.receiver.send(param) } }
              content = ->(_vc = nil) { component_fake_output(component_class, render_params) }
              content.call
            else
              original.call(args[0], &block)
            end
          end
        end
        # rubocop:enable RSpec/AnyInstance
      end
    end

    included do
      let!(:component_stubs) { { } }

      def component_fake_output(stubbed_component, params)
        output = "!!!#{stubbed_component} RENDERED!!!"
        output += params.to_s if params

        output
      end
    end

    matcher :have_rendered do
      match do |rendered|
        unless component_stubs[expected]
          raise "#{expected} has not been stubbed. Please stub it before using have_rendered"
        end

        expect(component_stubs[expected]).to have_received(:render_in)
        if !options.empty? && !kw_options.empty?
          expect(expected.constantize).to have_received(:new).with(options, kw_options).at_least(1).time
        elsif !options.empty? && kw_options.empty?
          expect(expected.constantize).to have_received(:new).with(options).at_least(1).time
        elsif options.empty? && !kw_options.empty?
          expect(expected.constantize).to have_received(:new).with(kw_options).at_least(1).time
        end

        html = rendered.is_a?(String) ? rendered : rendered.native.inner_html
        html.include?(component_fake_output(component_stubs[expected].class, nil))
      end

      def with(options = [], kw_options = { })
        @options = options
        @kw_options = kw_options
        self
      end

      private

      def kw_options
        @kw_options ||= { }
      end

      def options
        @options ||= []
      end

      def failure_message
        msg = "expected cell to render #{expected}#2"
        msg += "\n with options:\n\n #{options}\n" if @options

        msg
      end
    end
  end
end
