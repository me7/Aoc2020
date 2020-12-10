include prelude
import strscans

type
  Bag = tuple[n:int, c:string]
  Db = Table[string, seq[Bag]]

proc createDb(src: string):Db =
  var 
    c1, contents, c2: string
    n: int
  for line in src.strip.splitLines:
    if line.scanf("$+ bags contain $+", c1, contents):
      result[c1] = @[]
      for b in contents.split(", "):
        if b.scanf("$i $+ bag", n, c2):
          result[c1].add (n, c2)

proc countBagsIn(bags:Db, color: string):int =
  if not bags.hasKey(color): return 0
  for b in bags[color]:
    result += b.n + b.n * countBagsIn(bags, b.c)

var bags = createDb(readFile("inputs/07e.txt"))
echo bags
echo bags.haveColor("shiny gold")