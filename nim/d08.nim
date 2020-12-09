import strscans, strutils, strformat

type
  Instruction = enum acc, jmp, nop
  Instructions = seq[(Instruction, int)]

let example = """nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"""

proc parse(s:string):Instructions =
  for line in s.strip.splitLines:
    result.add (parseEnum[Instruction](line[0..2]), parseInt(line[4..^1]))


func part1(input: Instructions): (bool, int) =
  var 
    seen:set[int16]
    line = 0'i16
    accum:int
  # echo fmt"  before line:{line} accum:{accum}"
  while true:
    if line in seen: return (false, accum)
    if line >= input.len: return (true, accum)
    seen.incl line
    let inst = input[line]
    # echo fmt"{inst}"
    case inst[0]
    of nop: line.inc
    of jmp: line.inc(inst[1])
    of acc:
      accum.inc(inst[1])
      line.inc
    # echo fmt"   after line:{line} accum:{accum}"

func part2(input: var Instructions): int =
  func change(s: var Instruction) =
    s = if s == nop: jmp else: nop
  for i in 0 ..< input.len:
    if input[i][0] in {jmp, nop}:
      change input[i][0]
      let f = part1(input)
      if f[0]: return f[1]
      change input[i][0]

echo part1(parse(example))

var instuctions = parse(readFile("inputs/08.txt"))
echo part1(instuctions)[1]
echo part2(instuctions)
# echo parse(readFile("inputs/08.txt")).len