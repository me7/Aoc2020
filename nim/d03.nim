import strutils, strformat, math

var example = readFile("d03ex").splitLines
var data = readFile("d03.txt").splitLines

proc slide(data: seq[string], right, down: int):int =
  var line, col = 0
  while line < data.len - 1:
    col = (col + right) mod data[line].len
    line.inc down
    if data[line][col] == '#': inc(result)

proc part1 =
  echo data.slide(3,1)

proc part2 =
  var steps = [(1,1), (3,1), (5,1), (7,1), (1,2)]
  var ans = 1
  for n in steps:
    ans = ans * data.slide(n[0], n[1])
  echo ans

part1()
part2()