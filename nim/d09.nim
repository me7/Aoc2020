import strutils, sequtils, strformat, math

let example = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

# first part use 30 min -> fastest is 1:27 min = 20x slower
proc part1(src: string, preamble:int = 5):int =
  var list = src.strip.splitLines.map(parseInt)
  for i, n in list[preamble..^1]:
    block outer:
      for o in list[i..<i+preamble]:
        for p in list[i+1..<i+preamble]:
          if n == o + p:
            # echo fmt"{n} == {o} + {p}"
            break outer
      return n

assert part1(example) == 127

# 2nd in 20 minutes, total = 50 min --> faster = 2:54 = 20x slower
proc part2(src: string, target: int): int =
  var list = src.strip.splitLines.map(parseInt)
  var start, stop, total = 0
  while total != target:
    if total < target: inc stop else: inc start
    total = sum(list[start..stop])
    # echo fmt"{list[start..stop]} = {total}"
  return min(list[start..stop]) + max(list[start..stop])

assert part2(example, 127) == 62

echo part1(readFile("inputs/09.txt"), 25)
echo part2(readFile("inputs/09.txt"), 177777905)