module Support
  module WithEveryCombination
    # Takes an hash of variable names to all possible values, and creates RSpec contexts for
    # every possible combination of values
    #
    # The goal is to avoid both specs based on .sample, which are never full and safe and can lead to flaky test suite,
    # and to avoid big, repetitive specs where you have to write down the combinations yourself
    #
    # For example:
    #   with_every_combination(
    #     assignment: [Assignments::Models::Assignment.new, nil],
    #     start_date: [Date.current - rand(1..10).months, nil],
    #     end_date: [Date.current + rand(1..10).months, nil]
    #   ) do
    #     ...
    #   end
    #
    # It can also take a lambda that can reject values.
    #
    # For example:
    #
    #   with_every_combination(
    #     reject_combinations: ->(x) { x.values.all?(false) },
    #     can_approve: [true, false],
    #     can_reject: [true, false],
    #     can_update_vetting_notes: [true, false]
    #   ) do
    #     ...
    #   end
    def with_every_combination(reject: nil, **values, &block)
      combinations = values.map { |k, v| v.map { |value| [k, value] } }
                           .then { |c| c.shift.product(*c) }.map(&:to_h)

      combinations.reject!(&reject) if reject

      context "with combinations" do
        combinations.each do |combination|
          context "with combination #{combination.inspect}" do
            combination.each do |attr, value|
              let(attr) { value }
            end

            class_exec(&block)
          end
        end
      end
    end
  end
end
