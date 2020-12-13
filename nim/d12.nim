let example = """F10
N3
F7
R90
F11"""

import strutils

type
  Point = tuple[x,y: int]
  Instruction = tuple[op: char, val: int]
  Instructions = seq[Instruction]

proc part1 =
  var 
    ship:Point = (0, 0)
    waypoint:Point = (1, 0)
    ins:Instructions
  
  for line in readFile("inputs/12.txt").strip.splitLines:
    ins.add (line[0], line[1..^1].parseInt)
  
  for (op, val) in ins:
    case op:
      of 'N': ship.y -= val
      of 'E': ship.x += val
      of 'S': ship.y += val
      of 'W': ship.x -= val
      of 'F':
        ship.x += waypoint.x * val
        ship.y += waypoint.y * val
      of 'L':
        for _ in 1..(val div 90):
          waypoint = (waypoint.y, -waypoint.x)
      of 'R':
        for _ in 1..(val div 90):
          waypoint = (-waypoint.y,  waypoint.x)
      else: discard
    # echo (op, val, ship)
  echo abs(ship.x) + abs(ship.y)

proc part2 =
  var 
    ship:Point = (0, 0)
    waypoint:Point = (10, -1)
    ins:Instructions
  
  for line in readFile("inputs/12.txt").strip.splitLines:
    ins.add (line[0], line[1..^1].parseInt)
  
  for (op, val) in ins:
    case op:
      of 'N': waypoint.y -= val
      of 'E': waypoint.x += val
      of 'S': waypoint.y += val
      of 'W': waypoint.x -= val
      of 'F':
        ship.x += waypoint.x * val
        ship.y += waypoint.y * val
      of 'L':
        for _ in 1..(val div 90):
          waypoint = (waypoint.y, -waypoint.x)
      of 'R':
        for _ in 1..(val div 90):
          waypoint = (-waypoint.y,  waypoint.x)
      else: discard
    # echo (op, val, waypoint)
  echo abs(ship.x) + abs(ship.y)

part1()
part2()