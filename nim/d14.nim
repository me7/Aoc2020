const ex1 = """mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0"""

import strscans, strutils, tables, sequtils

proc part1(src: string):int =
  var
    mem, val: int
    mask, valBin: string
    ans: Table[int, int]
  for line in src.splitLines:
    if line.scanf("mask = $+", mask): discard
    else:
      if line.scanf("mem[$i] = $i", mem, val):
        valBin = val.toBin(mask.len)
        for i, c in mask:
          case c:
            of '1': valBin[i] = '1'
            of '0': valBin[i] = '0'
            else: discard
      ans[mem] = valBin.parseBinInt
  return toSeq(ans.values).foldl(a+b)

assert part1(ex1) == 165
echo part1(readFile("inputs/14.txt"))


const ex2 = """mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1"""

proc floatingMem(mask:string): seq[int] =
  var xCount = mask.count('X')
  for i in 0 ..< 1 shl xCount:
    var 
      binNum = i.toBin(xCount)
      tempM = mask
    var j = 0
    for i, c in mask:
      if c == 'X':
        tempM[i] = binNum[j]
        inc j
    result.add tempM.parseBinInt

proc part2(src: string):int =
  var
    mem,val: int
    mask, memStr: string
    ans: Table[int, int]
  for line in src.splitLines:
    if line.scanf("mask = $+", mask): discard
    else:
      if line.scanf("mem[$i] = $i", mem, val):
        memStr = mem.toBin(mask.len)
        for i, c in mask:
          case c:
            of '1': memStr[i] = '1'
            of 'X': memStr[i] = 'X'
            else: discard
        for mem in floatingMem(memStr):
          ans[mem] = val
  return toSeq(ans.values).foldl(a+b)

assert part2(ex2) == 208
echo part2(readFile("inputs/14.txt"))