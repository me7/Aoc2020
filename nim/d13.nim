var example="""939
7,13,x,x,59,x,31,19"""

import strutils, sugar, sequtils, math

proc part1 =
  var
    input = readFile("inputs/13.txt").strip.splitLines
    depart = input[0].parseInt
    busses = collect(newSeq):
      for i in input[1].split(','):
        if i != "x":
          parseInt(i)
  var wait = busses.mapIt(it - (depart mod it))
  let i = wait.minIndex
  echo busses[i] * wait[i] 

proc part2 =
  var
    input = readFile("inputs/13.txt").strip.splitLines[1].split(',')
    buses:seq[(int, int)]
  for i, bus in input:
    if bus != "x":
      buses.add (i, bus.parseInt)

  var
    result = 0
    prime = 1
  for (i, bus) in buses:
    let delay = floorMod(bus-i, bus)
    let newPrime = prime * bus
    for n in countup(result, newPrime, prime):
      if n mod bus == delay:
        result = n
        prime = newPrime
        break
  echo result

part1()
part2()