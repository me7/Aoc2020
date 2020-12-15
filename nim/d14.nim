import strscans, strutils, tables, sequtils, algorithm, bitops, math #, system

const example = """mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
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

assert part1(example) == 165
echo part1(readFile("inputs/14.txt"))


const ex2 = """mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1"""

# x1101x = [26, 27, 58, 59]
proc memList(mask: string): seq[int64] =
  var 
    m = mask
    xCount = mask.count('X')
  for n in 0 ..< 1 shl xCount:
    let b = n.toBin(xCount)
    var j = 0
    for i, c in mask:
      if c == 'X':
        m[i] = b[j]
        inc j
    result.add parseBinInt(m)

proc part2(src: string): int64 =
  var
    mask, memStr, valStr: string
    mem, val: int64
    ans: Table[int64, int64]
  for line in src.strip.splitLines:
    if line.scanf("mask = $+", mask): discard
    if line.scanf("mem[$+] = $+", memStr, valStr):
      mem = parseBiggestInt(memStr)
      val = parseBiggestInt(valStr)
      let memBin = mem.toBin(36)
      for i, c in mask:
        case c:
          of '0': mask[i] = memBin[i]
          of '1': mask[i] = '1'
          else: discard
      for mem in memList(mask):
        ans[mem] = val
  # echo ans
  result = toSeq(ans.values()).sum


assert part2(ex2) == 208
echo part2(readFile("inputs/14.txt"))