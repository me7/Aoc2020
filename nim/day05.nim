import strutils, algorithm, sequtils, sets
type
  Seat = int16
  Seats = set[int16]

proc encode(s:string):Seat =
  for i, c in s:
    if c in ['B', 'R']:
      result += 1'i16 shl (s.high - i)

proc solve(fn:string):(int, int) =
  var 
    seats, allSeats :Seats

  for i in fn.lines:
    var seat = encode(i)
    seats.incl(seat)
    if seat > result[0]: 
      result[0] = seat
  
  var seatseq = toSeq(seats)
  for i in min(seatseq)..max(seatseq):
    allSeats.incl(i)
  result[1] = toSeq(allSeats - seats)[0]

# subtract by map(+1) --> from https://github.com/betaveros/advent-of-code-golf-2020/blob/master/day5-2.prdc
proc solve2(fn:string):(int, int) =
  var 
    seats, allSeats :seq[int16]

  for i in fn.lines:
    var seat = encode(i)
    seats.add(seat)
    if seat > result[0]: 
      result[0] = seat
  
  allSeats = seats.mapIt(it+1)
  result[1] = toSeq(allSeats.toHashSet - seats.toHashSet).min

echo solve("inputs/05.txt")
echo solve2("inputs/05.txt")