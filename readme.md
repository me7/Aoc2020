# Advent of Code 2020 in Nim Language

My try to solve it by myself first the search search for Nim solution in [reddit](https://old.reddit.com/r/adventofcode)

## Knowledge So far
Day|Minute Part1|Part 2|TIL
---|---|---|---
Day 1 | ||read data in one liner code by strutils and sequtil --> let data = toSeq("file".lines).map(parseInt)
Day 2 | ||using [scanf][1] proc that [easier than regex][2]
Day 3 | ||mod
Day 4 | ||not in 1..5, splitWhiteSpace
Day 5 | ||shl, sets *intersect +union -subtract
Day 6||60|countTable, always strip input file
Day 7|Inf||recursive, scanf
Day 8|Inf||index by 1 error (if line >= input.len), parseEnum
Day 9|30|20|assert solve(example)==correct before use puzzle input
Day 10|Inf|Inf|part 2 is too hard for me to create algorithm --> [answer](python/d10.py)
Day 11|Inf|Inf|learn Grid system (row, column)
Day 12|Inf|Inf|learn Planar system (x, y)


since day 10 onward code from Narimiran and Jonathan Pualson

Day|Minute|TIL
---|---|---
Day 13a|Inf|wait = bus - (depart mod bus)
Day 13b|Inf|chinese modulo which I not understand

[1]: https://nim-lang.org/docs/strscans.html#scanf.m%2Cstring%2Cstatic%5Bstring%5D%2Cvarargs%5Btyped%5D
[2]: https://pietroppeter.github.io/adventofnim/2020/day02.html