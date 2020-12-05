import strutils, sequtils, re

var data = toSeq("inputs/02.txt".lines)

# 7-8 b: dbbpbbqdj mean have b 7-8 times
proc okPassword(pw: string): bool =
  var m:array[4, string]
  let pat = re"(\d+)-(\d+)\s(\w):\s(.*)"
  if pw.match(pat, m):
    var count = 0
    for c in m[3]:
      if $c == m[2]:
        count.inc
    return count >= m[0].parseInt and count <= m[1].parseInt

proc part1: int =
  result = 0
  for d in data:
    if okPassword(d):
      result.inc

# 7-8 b: dbbpbbqdj mean have either position 7 or 8 have b (index 1)
proc okPassword2(pw:string): bool =
  var m:array[4, string]
  let pat = re"(\d+)-(\d+)\s(\w):\s(.*)"
  if pw.match(pat, m):
    var want = m[2]
    var pos1 = m[3][m[0].parseInt - 1]
    var pos2 = m[3][m[1].parseInt - 1]
    return ($pos1 == want) xor ($pos2 == want)

proc part2: int =
  result = 0
  for d in data:
    if okPassword2(d):
      result.inc


echo part1()
echo part2()