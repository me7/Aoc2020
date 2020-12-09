import strutils, strscans, tables, sets, strformat

type
  Bag = tuple[amount:int, color:string]
  Bags = seq[Bag]
  BagsHash = Table[string, Bags]
  BagsDB = tuple[bigger, smaller: BagsHash]


proc createDB(path: string): BagsDB =
  var 
    amount: int
    c1, contents, c2: string
  for line in lines(path):
    if line.scanf("$+ bags contain $+", c1, contents):
      result.smaller[c1] = @[]
      for bag in contents.split(", "):
        if bag.scanf("$i $+ bag", amount, c2):
          result.bigger.mgetOrPut(c2, @[]).add (0, c1)
          result.smaller[c1].add (amount, c2)

proc part1(b: BagsHash, color: string):int =
  proc aux(b: BagsHash, current: string, seen: var HashSet[string]) =
    if not b.hasKey(current): return
    for bag in b[current]:
      if not seen.containsOrIncl(bag.color):
        aux(b, bag.color, seen)
  var seen: HashSet[string]
  aux(b, color, seen)
  result = seen.card

proc part2(b: BagsHash, current:string): int =
  if b[current].len == 0: return 0
  for bag in b[current]:
    result += bag.amount * (1 + part2(b, bag.color))

let db = createDB("inputs/07.txt")
echo part1(db.bigger, "shiny gold")
echo part2(db.smaller, "shiny gold")