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

      def run_case1
        sequences = filter_valid_order_updates
        sum_middle_pages_of_sequences(sequences)
      end

      def filter_invalid_order_updates
        pages_updates.reject { |sequence| add_to_updates_filter?(sequence, ordering_rules) }
      end

      def filter_valid_order_updates
        pages_updates.select { |sequence| add_to_updates_filter?(sequence, ordering_rules) }
      end

      def sum_middle_pages_of_sequences(sequences)
        sequences.map { |sequence| sequence[sequence.size / 2] }.sum
      end

      def order_sequence(sequence)
        invalid_pages_indexes = get_invalid_value_indexes(sequence)

        invalid_pages = invalid_pages_indexes.map { |index| sequence[index] }
        filtered_pages = sequence - invalid_pages

        sort_pages(filtered_pages, invalid_pages)
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

      def get_invalid_value_indexes(sequence)
        invalid_values_indexes = []

        sequence.each_with_index do |page, index|
          next if index == sequence.size - 1

          possible_next_pages = ordering_rules[page]
          next_page = sequence[index + 1]
          next if possible_next_pages&.include?(next_page)

          invalid_values_indexes << index
        end

        invalid_values_indexes
      end

      def sort_pages(filtered_pages, invalid_pages)
        sorted_pages = filtered_pages.dup

        invalid_pages.each do |invalid_page|
          invalid_page_options = ordering_rules[invalid_page]
          last_page_options = ordering_rules[sorted_pages.last]

          if invalid_page_options.nil? || last_page_options&.include?(invalid_page)
            sorted_pages << invalid_page
            next
          end

          sort_pages_array_content(sorted_pages, invalid_page, invalid_page_options)
        end

        sorted_pages
      end

      def sort_pages_array_content(sorted_pages, invalid_page, invalid_page_options)
        sorted_pages.each_with_index do |page, index|
          next if index == sorted_pages.size - 1

          next_page = sorted_pages[index + 1]
          page_options = ordering_rules[page]

          next unless page_options.include?(invalid_page)
          next unless invalid_page_options.include?(next_page)

          sorted_pages.insert(index + 1, invalid_page)
          break
        end
      end
    end
  end
end
