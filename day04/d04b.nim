import strutils, sequtils

proc solve(fn:string):(int, int) =
  let
    input = readFile(fn).replace("\c\n", "\n").split("\n\n")
  echo input[0].splitWhitespace
  (4,5)


echo solve("example")