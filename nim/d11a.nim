var example = """L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"""

import strutils, sequtils, tables, sugar

type
  Seats = seq[string]

proc updateSeat(s: var Seats): bool =
  let L = s.deepCopy
  var R = high L
  var C = high L[0]
  for r in 0..R:
    for c in 0..C:
      var occ = 0
      for dr in -1..1:
        for dc in -1..1:
          if not (dr == 0 and dc == 0):
            var rr = r + dr
            var cc = c + dc
            while rr in 0..R and cc in 0..C and L[rr][cc] == '.':
              rr = rr + dr
              cc = cc + dc
            if rr in 0..R and cc in 0..C and L[rr][cc] == '#':
              occ += 1
      if L[r][c] == 'L': 
        if occ == 0:
          s[r][c] = '#'
          result = true
      elif L[r][c] == '#' and occ >= 5:
        s[r][c] = 'L'
        result = true

var L:Seats = readFile("inputs/11.txt").strip.splitLines
while L.updateSeat:
  # echo L
  discard

var ans = 0
for r in 0..L.high:
  for c in 0..L[0].high:
    if L[r][c] == '#':
      ans += 1
echo ans