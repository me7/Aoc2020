let example = """16
10
15
5
1
11
7
19
6
12
4"""

let example2 = """28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3"""

import sequtils, strutils, algorithm, math, tables

# part 1 use 50 minutes
proc solve1(src:string): int =
  let adapter = toSeq(src.strip.splitLines).map(parseInt).sorted
  # echo adapter

  var diff:seq[int]
  for i in 1..adapter.high:
    diff.add adapter[i] - adapter[i-1]
  
  let diff3 = diff.count(3)+1 
  let diff1 = diff.count(1)+1
  return diff1 * diff3


proc solve2(src:string): int =
  let adapter = src.strip.splitLines.map(parseInt).sorted
  echo adapter

  var diff:seq[int]
  for i in 1..adapter.high:
    diff.add adapter[i] - adapter[i-1]
  
  let diff3 = diff.count(3)+1
  ## 31 - 20
  ## 11 - 8
  echo 2'f32.pow(11)
  echo adapter.len

assert solve1(example) == 35
assert solve1(example2) == 220
echo solve1(readFile("inputs/10.txt"))


# lines = [0] + sorted(map(int,open("inputs/10.txt").readlines()))
let lines:seq[int] = @[0] & toSeq(readFile("inputs/10.txt").strip.splitLines).map(parseInt).sorted

# diffs = {1:0,3:1}
# for i in range(1,len(lines)):
#     diffs[lines[i]-lines[i-1]]+=1
# print('part 1:', diffs[1]*diffs[3])
var diff = {1:0, 3:1}.toTable
for i in 1..lines.high:
  diff[lines[i] - lines[i-1]] += 1
echo "part 1: ", diff[1] * diff[3]

# @lru_cache(maxsize=None) 
# def howmany(i):
#     return (1 if i == len(lines)-1
#               else sum(howmany(j) for j,x in enumerate(lines[i+1:i+4],start=i+1) if x<=lines[i]+3))
# print('part 2:',howmany(0))
proc howMany(i:int): int =
  if i == lines.len-1: return 1
  else:
    for j in lines[i+1..i+4]:
      echo j
echo howMany(10)
