module Year2024
  module Day5
    class Resolver
      FILE_PATH = 'lib/year2024/day5/input.txt'.freeze

      attr_reader :file_content, :ordering_rules, :pages_updates

      def initialize(path = nil)
        file_content = File.read(path || FILE_PATH)

        rules, updates = file_content.split("\n\n")
        build_ordering_rules(rules)
        build_updates(updates)
      end

      def filter_valid_order_updates
        pages_updates.select { |sequence| add_to_updates_filter?(sequence, ordering_rules) }
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

      def build_updates(updates)
        @pages_updates = updates.split("\n").map { |line| line.split(',').map(&:to_i) }
      end

      def add_to_updates_filter?(sequence, rules)
        sequence.each_with_index do |page, index|
          next if index == sequence.size - 1

          possible_next_pages = rules[page]
          return false if possible_next_pages.nil?

          next_page = sequence[index + 1]
          return false unless rules[page].include?(next_page)
        end
      end
    end
  end
end
