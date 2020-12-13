# https://github.com/narimiran/AdventOfCode2020/blob/master/nim/day10.nim
import strutils, sequtils, tables, algorithm
import nimprof

func solve(adapters: seq[int]): (int, int) =
  var
    joltages = sorted adapters
    ones, threes: int
    ways = [0].toCountTable
  let largestAdapter = joltages[^1]
  joltages.add largestAdapter+3
  for i, jolt in joltages:
    if i == joltages.high: break
    case joltages[i+1] - jolt
    of 1: inc ones
    of 3: inc threes
    else: discard
    ways[jolt] = ways[jolt-3] + ways[jolt-2] + ways[jolt-1]
    # debugEcho ways
  result[0] = ones * threes
  result[1] = ways[largestAdapter]

let adapters = toSeq("inputs/10.txt".lines).map(parseInt)

echo solve(adapters)