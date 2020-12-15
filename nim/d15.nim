import tables, strutils

const input = @[0,14,1,3,7,9]

# 2h
proc solve(inp:seq[int], step:int):int =
  var 
    ans:Table[int, seq[int]]
    num = 0
  for round in 1..step:
    if round <= inp.len:
      num = inp[round-1]
      ans[num] = @[round]
    elif not ans.hasKey(num):
      # echo ("nokey", num)
      num = 0
      ans[num] = @[]
      ans[num].add @[round]
    elif ans[num].len == 1: # last time was new number
      # echo ("len1", num)
      num = 0
      if ans.hasKey(0):
        ans[0].add round
      else:
        ans[0] = @[round]
    elif ans[num].len >= 2:
      num = ans[num][^1] - ans[num][^2]
      if ans.hasKey(num):
        ans[num].add round
      else:
        ans[num] = @[round]
    else:
      echo "FAIL"
    # echo (round, num, ans)
  result = num

proc part1(src:seq[int]):int = solve(src, 2020)
proc part2(src:seq[int]):int = solve(src, 30_000_000)

assert part1(@[0,3,6]) == 436
assert part1(@[1,3,2]) == 1
assert part1(@[2,1,3]) == 10
assert part1(@[1,2,3]) == 27
assert part1(@[2,3,1]) == 78
assert part1(@[3,2,1]) == 438
assert part1(@[3,1,2]) == 1836
echo part1(input)

echo part2(input)