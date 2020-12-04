# translate from Ruby https://old.reddit.com/r/adventofcode/comments/k6e8sw/2020_day_04_solutions/gel4pb2/

import strutils, tables, sequtils, sets, re
type Passport = Table[string, string]

proc parseRow(r:string):Passport =
  for i in r.split({' ','\n'}):
    var c = i.split(':')
    result[c[0]] = c[1]

proc parseFile(fn:string):seq[Passport] =
  var txt = readFile(fn).replace("\c\n","\n")
  var passportsTxt = txt.split("\n\n")
  result = passportsTxt.map(parseRow)

proc validate1(p:Passport): bool =
  var required = toHashSet("byr iyr eyr hgt hcl ecl pid".split(' '))
  var keys = toSeq(p.keys()).toHashSet
  result = len(keys * required) == 7

proc part1(fn:string):int =
  for p in parseFile(fn):
    if validate1(p):
      result.inc

proc intIsBetween(s:string, min, max:int):bool {.inline.} = 
  var i = s.parseInt
  return (i >= min) and (i <= max)

proc heightOk(p:Passport):bool =
  var 
    h = p.getOrDefault("hgt")
    unit = h[^2..^1]
    value = h[0..^3]
  case unit:
    of "cm": 
      if not (value.intIsBetween(150, 193)): return
    of "in":
      if not (value.intIsBetween(59, 76)): return
    else: return
  return true

proc validate2(p:Passport): bool =
  result = p.validate1 and 
    p.getOrDefault("byr").intIsBetween(1920, 2002) and
    p.getOrDefault("iyr").intIsBetween(2010, 2020) and
    p.getOrDefault("eyr").intIsBetween(2020, 2030) and
    p.getOrDefault("hcl").match(re"^#[0-9a-f]{6}$") and
    toSeq("amb blu brn gry grn hzl oth".split(' ')).contains(p.getOrDefault("ecl")) and
    p.getOrDefault("pid").match(re"^\d{9}$") and
    p.heightOk

proc part2(fn:string):int =
  result = parseFile(fn).filter(validate2).len

echo part1("input")
echo part2("input")