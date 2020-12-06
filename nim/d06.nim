import strutils, tables

# part 1 = 14:35 - 14:17 = 18 minutes
proc solve1(s:string):int =
  for group in s.split("\n\n"):
    var ans: set[char]
    var g = group.replace("\n","")
    for c in g:
      ans.incl(c)
    result += ans.card

# part 2 = 14:36 - 15:08 = 32 minutes
# 1st submit 15:02 = 3399 = too low
# 2nd submit 15:08 = 3406 = fixed by add strip when readFile
proc solve2(s:string):int =
  for group in s.split("\n\n"):
    var numPeople = group.split("\n").len
    var cnt = newCountTable("")
    for l in group.replace("\n",""):
      cnt.inc(l)

    var allYes:int
    for k,v in cnt:
      if v >= numPeople:
        allYes.inc

    result += allYes
    # echo (allYes, numPeople, cnt)

var example = """abc

a
b
c

ab
ac

a
a
a
a

b"""

assert solve1(example) == 11
assert solve2(example) == 6

echo solve1(readFile("inputs/06.txt"))
echo solve2(readFile("inputs/06.txt").strip())