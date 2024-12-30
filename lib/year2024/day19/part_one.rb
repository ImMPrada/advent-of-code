lines = File.readlines('lib/year2024/day19/input.txt').map(&:chomp)
patterns = lines[0].split(', ').map(&:strip)
designs = lines[2..].reject(&:empty?)

def possible?(design, patterns)
  desings_total = design.length
  possible_designs = Array.new(desings_total, false)

  (0...desings_total).each do |i|
    possible_designs[i] = true if patterns.include?(design[0..i])
    try_pattern_at_position(design, patterns, possible_designs, i)
  end

  possible_designs[desings_total - 1]
end

def try_pattern_at_position(design, patterns, possible_designs, position)
  patterns.each do |pattern|
    pattern_length = pattern.length
    next if position < pattern_length - 1

    next unless design[(position - pattern_length + 1)..position] == pattern &&
                (position == pattern_length - 1 || possible_designs[position - pattern_length])

    possible_designs[position] = true
    break
  end
end

puts "\e[33mChecking designs...\e[0m"
count = 0

designs.each do |design|
  if possible?(design, patterns)
    puts "\e[32m  #{design} is possible\e[0m"
    count += 1
  else
    puts "\e[31m  #{design} is impossible\e[0m"
  end
end

puts "\e[32mAnswer: #{count}\e[0m"
