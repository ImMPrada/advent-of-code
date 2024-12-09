module Year2024
  module Day5
    class Resolver
      FILE_PATH = 'lib/year2024/day5/input.txt'.freeze

      attr_reader :file_content, :ordering_rules, :pages_updates

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)

        rules, updates = file_content.split("\n\n")
        build_ordering_rules(rules)
        build_ordering_updates(updates)
      end

      private

      def build_ordering_rules(rules)
        @ordering_rules = {}

        rules.split("\n").each do |line|
          rule = line.split('|')
          key = rule[0].to_i
          next_page = rule[1].to_i

          if @ordering_rules[key]
            @ordering_rules[key] << next_page
          else
            @ordering_rules[key] = [next_page]
          end
        end
      end

      def build_ordering_updates(updates)
        @pages_updates = updates.split("\n").map { |line| line.split(',').map(&:to_i) }.flatten
      end
    end
  end
end
