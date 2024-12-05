# Year 2024

- [Day 1](#day-1)
- [Day 2](#day-2)
- [Day 3](#day-3)
- [Day 4](#day-4)
- [Day 5](#day-5)
- [Day 6](#day-6)
- [Day 7](#day-7)
- [Day 8](#day-8)
- [Day 9](#day-9)
- [Day 10](#day-10)
- [Day 11](#day-11)
- [Day 12](#day-12)
- [Day 13](#day-13)
- [Day 14](#day-14)
- [Day 15](#day-15)
- [Day 16](#day-16)
- [Day 17](#day-17)
- [Day 18](#day-18)
- [Day 19](#day-19)
- [Day 20](#day-20)
- [Day 21](#day-21)
- [Day 22](#day-22)
- [Day 23](#day-23)
- [Day 24](#day-24)
- [Day 25](#day-25)

## Day 1

### Part One

Help the Senior Historians find the Chief Historian by collecting fifty stars. Solve puzzles to earn stars.

Example:
```
3   4
4   3
2   5
1   3
3   9
3   3
```
Total distance: 11.

### Part Two

Calculate the similarity score by finding how often each number from the left list appears in the right list.

Example:
```
3   4
4   3
2   5
1   3
3   9
3   3
```
Similarity score: 31.

[Link to the challenge](https://adventofcode.com/2024/day/1)

### Run it locally

```bash
irb
require './lib/year2024/day1/resolver.rb'
resolver = Year2024::Day1::Resolver.new
resolver.run_case1 # => result for part one
resolver.run_case2 # => result for part two
```

## Day 3

### Part One

The North Pole Toboggan Rental Shop's computers are having issues, and the memory (your puzzle input) is corrupted. The goal is to multiply numbers using instructions like mul(X,Y), but many invalid characters should be ignored.

For example, in the corrupted memory:
`xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))`
Only valid mul instructions should be considered. Adding up the results gives 161 (2*4 + 5*5 + 11*8 + 8*5).

### Part Two

Handle new instructions: do() enables and don't() disables future mul instructions. Only the most recent do() or don't() applies.

For example:
`xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))`
Here, mul(5,5) and mul(11,8) are disabled. The sum is 48 (2*4 + 8*5).

[Link to the challenge](https://adventofcode.com/2024/day/3)

### Run it locally

Open the ruby console

```bash
irb
```

Run the Resolver:

```bash
require './lib/year2024/day3/resolver.rb'
resolver = Year2024::Day3::Resolver.new
resolver.run_case1 # => the result for part one
resolver.run_case2 # => the result for part two
```

