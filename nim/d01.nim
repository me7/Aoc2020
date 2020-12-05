import strutils, sequtils

let data = toSeq("d01.txt".lines).map(parseInt)

proc part1:int =
  for i,n in data:
    for o in data[i+1 .. ^1]:
      if n + o == 2020:
        return n * o

assert part1() == 1003971

proc part2: int =
  for i, n in data:
    for o in data[i+1 .. ^1]:
      for p in data[i+2 .. ^1]:
        if n + o + p == 2020:
          # echo "$1 $2 $3" % [$n, $o, $p]
          return n * o * p

assert part2() == 84035952