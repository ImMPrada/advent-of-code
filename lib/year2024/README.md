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

resolver = Year2024::Day1::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 2

### Part One

Analyze the unusual data from the engineers. How many reports are safe?

Example:
```
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```
Safe reports: 2.

### Part Two

Update your analysis by handling situations where the Problem Dampener can remove a single level from unsafe reports. How many reports are now safe?

Example:
```
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
```
Safe reports: 4.

[Link to the challenge](https://adventofcode.com/2024/day/2)

### Run it locally

```bash
irb
require './lib/year2024/day2/resolver.rb'
resolver = Year2024::Day2::Resolver.new
resolver.run_case1 # => result for part one
resolver = Year2024::Day2::Resolver.new
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

resolver = Year2024::Day3::Resolver.new
resolver.run_case2 # => the result for part two
```

# Day 4

### Part One

Help the Elf find all instances of the word "XMAS" in the word search.

Example:
```
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
```
Occurrences of "XMAS": 18.

### Part Two

Find all instances of "X-MAS" in the word search, where "X-MAS" is formed by two "MAS" in the shape of an X.

Example:
```
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
```
Occurrences of "X-MAS": 9.

[Link to the challenge](https://adventofcode.com/2024/day/4)

### Run it locally

```bash
irb
require './lib/year2024/day4/resolver.rb'
resolver = Year2024::Day4::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day4::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 5

### Part One

Determine which updates are already in the correct order based on the given page ordering rules.

Example:
```
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
```
Correctly ordered updates: 75,47,61,53,29; 97,61,53,29,13; 75,29,13.

Middle page numbers: 61, 53, 29.

Sum of middle page numbers: 143.

### Part Two

Fix the incorrectly-ordered updates using the page ordering rules.

Example:
```
75,97,47,61,53 becomes 97,75,47,61,53.
61,13,29 becomes 61,29,13.
97,13,75,29,47 becomes 97,75,47,29,13.
```
Middle page numbers after reordering: 47, 29, 47.

Sum of middle page numbers: 123.

[Link to the challenge](https://adventofcode.com/2024/day/5)

### Run it locally

```bash
irb
require './lib/year2024/day5/resolver.rb'
resolver = Year2024::Day5::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day5::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 7

### Part One

Help engineers repair a rope bridge by determining which equations can be solved using addition (+) and multiplication (*) operators. Operators are evaluated left-to-right, and numbers cannot be rearranged.

Example:
```
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
292: 11 6 16 20
```
Only three equations can be made true:
- 190 = 10 * 19
- 3267 = 81 + 40 * 27 (or 81 * 40 + 27)
- 292 = 11 + 6 * 16 + 20

Sum of valid test values: 3749

### Part Two

A third operator is discovered: concatenation (||) which combines digits (e.g., 12 || 345 = 12345). Using all three operators (+, *, ||), find all possible valid equations.

Example using the same input, three additional equations become valid:
- 156 = 15 || 6
- 7290 = 6 * 8 || 6 * 15
- 192 = 17 || 8 + 14

New sum including all valid test values: 11387

[Link to the challenge](https://adventofcode.com/2024/day/7)

### Run it locally

```bash
irb
require './lib/year2024/day7/resolver.rb'
resolver = Year2024::Day7::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day7::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 8

### Part One

Help identify antinodes created by resonant frequencies from antennas. An antinode occurs when two antennas of the same frequency are perfectly aligned, with one being twice as far as the other.

Example:
```
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
```
Total unique antinode locations: 14.

### Part Two

Account for resonant harmonics: antinodes now occur at any grid position exactly in line with at least two antennas of the same frequency, regardless of distance.

Example (using the same input):
```
##....#....#
.#.#....0...
..#.#0....#.
..##...0....
....0....#..
.#...#A....#
...#..#.....
#....#.#....
..#.....A...
....#....A..
.#........#.
...#......##
```
Total unique antinode locations with harmonics: 34.

[Link to the challenge](https://adventofcode.com/2024/day/8)

### Run it locally

```bash
irb
require './lib/year2024/day8/resolver.rb'
resolver = Year2024::Day8::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day8::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 9

### Part One

Help an amphipod compact files on a disk by moving blocks one at a time. The disk map uses alternating digits to represent file lengths and free space lengths. Files have IDs based on their initial order (starting from 0).

Example:
```
2333133121414131402
```
Represents:
```
00...111...2...333.44.5555.6666.777.888899
```

Move blocks from the end to leftmost free space until no gaps remain. Calculate checksum by multiplying each block's position with its file ID and summing the results.

Example process:
```
00...111...2...333.44.5555.6666.777.888899
009..111...2...333.44.5555.6666.777.88889.
0099.111...2...333.44.5555.6666.777.8888..
...
0099811188827773336446555566..............
```
Checksum: 1928

### Part Two

Instead of moving individual blocks, move entire files to the leftmost available free space that can fit them. Process files in decreasing ID order, moving each file once if possible.

Same example, different process:
```
00...111...2...333.44.5555.6666.777.888899
0099.111...2...333.44.5555.6666.777.8888..
0099.1117772...333.44.5555.6666.....8888..
0099.111777244.333....5555.6666.....8888..
00992111777.44.333....5555.6666.....8888..
```
New checksum: 2858

[Link to the challenge](https://adventofcode.com/2024/day/9)

### Run it locally

```bash
irb
require './lib/year2024/day9/resolver.rb'
resolver = Year2024::Day9::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day9::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 10

### Part One

Help a reindeer map hiking trails in a Lava Production Facility using a topographic map. Valid hiking trails must start at height 0, end at height 9, and increase by exactly 1 at each step (only up, down, left, or right moves allowed). A trailhead's score is the number of height-9 positions reachable from that starting point.

Example:
```
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
```
This map has 9 trailheads with scores: 5, 6, 5, 3, 1, 3, 5, 3, and 5.
Sum of all trailhead scores: 36.

### Part Two

Calculate each trailhead's rating, which is the number of distinct possible hiking trails starting from that position. A trail is distinct if it follows a different path, even if it reaches the same endpoint.

Using the same example:
```
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
```
The trailheads have ratings: 20, 24, 10, 4, 1, 4, 5, 8, and 5.
Sum of all trailhead ratings: 81.

[Link to the challenge](https://adventofcode.com/2024/day/10)

### Run it locally

```bash
irb
require './lib/year2024/day10/resolver.rb'
resolver = Year2024::Day10::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day10::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 12

### Part One

Help the Elves calculate fencing costs for their garden regions. Each letter in the map represents a plant type, and connected plots (horizontally or vertically) of the same type form a region. Calculate the total fencing cost where each region's cost is its area × perimeter.

Example:
```
AAAA
BBCD
BBCC
EEEC
```

Region calculations:
- Region A: area 4 × perimeter 10 = 40
- Region B: area 4 × perimeter 8 = 32
- Region C: area 4 × perimeter 10 = 40
- Region D: area 1 × perimeter 4 = 4
- Region E: area 3 × perimeter 8 = 24

Total cost: 140

### Part Two

With bulk discount, use number of sides instead of perimeter length. Each straight section counts as one side, regardless of length. For example, an E-shaped region:

```
EEEEE
EXXXX
EEEEE
EXXXX
EEEEE
```

The E-shaped region has:
- Area: 17 plots
- Sides: 12 sections
- Price: 17 × 12 = 204

[Link to the challenge](https://adventofcode.com/2024/day/12)

### Run it locally

```bash
irb
require './lib/year2024/day12/resolver.rb'
resolver = Year2024::Day12::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day12::Resolver.new
resolver.run_case2 # => result for part two

# To visualize the garden:
resolver.visualize
```

## Day 13

### Part One

Help win prizes from unusual claw machines that have two buttons (A and B) instead of a joystick:
- Button A costs 3 tokens and moves the claw by specific X,Y amounts
- Button B costs 1 token and moves the claw by different X,Y amounts
- Must position claw exactly above prize coordinates

Example:
```
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=8400, Y=5400
```

For this machine:
- Pressing A 80 times and B 40 times reaches the prize
- Cost: (80 × 3) + (40 × 1) = 280 tokens

Find the minimum tokens needed to win all possible prizes, assuming no more than 100 button presses per machine.

### Part Two

Due to a unit conversion error, add 10000000000000 to both X and Y coordinates of every prize. Same example becomes:

```
Button A: X+94, Y+34
Button B: X+22, Y+67
Prize: X=10000000008400, Y=10000000005400
```

Now requires many more than 100 presses to win prizes. Calculate new minimum token cost.

[Link to the challenge](https://adventofcode.com/2024/day/13)

### Run it locally

```bash
irb
require './lib/year2024/day13/resolver.rb'
resolver = Year2024::Day13::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day13::Resolver.new
resolver.run_case2 # => result for part two
```

## Day 14

### Part One

Help predict robot movements in EBHQ's bathroom lobby. Robots move in straight lines and teleport when hitting edges. Each robot has:
- Position (p=x,y): distance from left and top walls
- Velocity (v=x,y): movement in tiles per second

Example:
```
p=0,4 v=3,-3
p=6,3 v=-1,-3
p=10,3 v=-1,2
```

After 100 seconds, count robots in each quadrant (ignoring middle lines) and multiply the counts:
```
..... 2..1.
..... .....
1.... .....
           
..... .....
...12 .....
.1... 1....
```
Quadrants have 1, 3, 4, and 1 robots.
Safety factor = 1 × 3 × 4 × 1 = 12

### Part Two

Find the Easter egg: the fewest seconds needed for robots to arrange into a Christmas tree pattern.

[Link to the challenge](https://adventofcode.com/2024/day/14)

### Run it locally

```bash
irb
require './lib/year2024/day14/resolver.rb'
resolver = Year2024::Day14::Resolver.new
resolver.run_case1(100, visualize: true) # => result for part one with visualization
resolver.run_case1(100) # => result for part one without visualization

resolver = Year2024::Day14::Resolver.new
resolver.run_case2 # => result for part two

# To visualize at any time:
resolver.visualize('custom_title')
```

Visualizations are saved in `visualizations/day14/` directory.

## Day 15

### Part One

Help lanternfish predict a malfunctioning warehouse robot's movements. The warehouse contains:
- Walls (#)
- Boxes (O)
- Robot (@)
- Empty spaces (.)

The robot follows movement instructions (^v<>) and can push boxes, but neither robot nor boxes can move through walls.

Example:
```
########
#..O.O.#
##@.O..#
#...O..#
#.#.O..#
#...O..#
#......#
########
```

Calculate sum of boxes' GPS coordinates after robot finishes moving:
- GPS = (distance from top × 100) + distance from left
- Example: box at row 1, column 4 has GPS = (1 × 100) + 4 = 104

### Part Two

The warehouse is twice as wide, with double-width boxes:
- Walls (#) become (##)
- Boxes (O) become ([])
- Empty (.) become (..)
- Robot (@) becomes (@.)

Example:
```
####################
##....[]....[]..[]##
##............[]..##
##..[][]....[]..[]##
##....[]@.....[]..##
##[]##....[]......##
```

Calculate new sum of GPS coordinates with wider boxes.

[Link to the challenge](https://adventofcode.com/2024/day/15)

### Run it locally

```bash
irb
require './lib/year2024/day15/resolver.rb'
resolver = Year2024::Day15::Resolver.new
resolver.run_case1 # => result for part one

resolver = Year2024::Day15::Resolver.new
resolver.run_case2 # => result for part two

# To visualize the warehouse:
resolver.visualize('initial')  # Show initial state
resolver.run_case1(visualize: true)  # Run with visualization every 10 steps
```

Visualizations are saved in `visualizations/day15/` directory, showing:
- Walls in black
- Boxes in green
- Robot in red
- Empty spaces as dots
