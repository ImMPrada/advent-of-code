require 'descriptive_statistics'

module Year2024
  module Day14
    module Statisticable
      def skewness(array)
        results = statistics(array)
        results[:median] - results[:mean]
      end

      def statistics(array)
        array.descriptive_statistics
      end
    end
  end
end
