require_relative 'resolver'

resolver = Year2024::Day14::Resolver.new
puts resolver.run_case1(100, visualize: false)

resolver = Year2024::Day14::Resolver.new
resolver.run_case2(20_000, visualize: true)
