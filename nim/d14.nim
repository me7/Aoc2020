import strscans, strutils, tables, sequtils, algorithm, bitops, math #, system

const example = """mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0"""

proc part1(src: string):int64 =
  var
    mask, valStr: string
    mem: int
    val: int64
    ans: Table[int, int64]
  for line in src.strip.splitLines:
    if line.scanf("mask = $+", mask):
      mask.reverse
    if line.scanf("mem[$i] = $+", mem, valStr):
      val = parseBiggestInt(valStr)
      for i, c in mask:
        case c:
          of '1': val.setBit(i)
          of '0': val.clearBit(i)
          of 'X': discard
          else: discard
      ans[mem] = val
  result = toSeq(ans.values()).foldl(a + b)

const example2 = """mask = 000000000000000000000000000000X1001X
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
  echo ans
  result = toSeq(ans.values()).sum


assert part1(example) == 165
echo part1(readFile("inputs/14.txt"))
# assert part2(example2) == 208
echo part2(readFile("inputs/14.txt"))