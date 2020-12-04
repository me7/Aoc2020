## This file not ok, look at d04a.nim

import strutils, sequtils, re

proc parseFile(fn:string):seq[string] =
  var d1 = readFile(fn).replace("\c\n", " ")
  result = d1.split("  ")

# ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm
proc validPassport(p:string):bool =
  let fields = @["ecl:", "pid:", "eyr:", "hcl:", "byr:", "iyr:", "hgt:"]
  result = false
  for f in fields:
    if not p.contains(f): return
  return true

# passports = File.read("4.txt").split("\n\n")

# passports.map! do |passport|
#   passport.scan(/(\w+{3})\:(\S+)/).to_h
# end

# puts passports.select { |passport|
#   (passport.keys & %w{byr iyr eyr hgt hcl ecl pid}).length == 7 &&
#   passport['byr'].to_i.between?(1920, 2002) &&
#   passport['iyr'].to_i.between?(2010, 2020) &&
#   passport['eyr'].to_i.between?(2020, 2030) &&
#   passport['hcl'] =~ /^\#[0-9a-f]{6}$/ &&
#   %w{amb blu brn gry grn hzl oth}.include?(passport['ecl']) &&
#   passport['pid'] =~ /^\d{9}$/ &&
#   ( 
#     (passport['hgt'].end_with?('cm') && passport['hgt'].to_i.between?(150, 193)) || (passport['hgt'].end_with?('in') && passport['hgt'].to_i.between?(59, 76))
#   )
# }.size


# ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm
proc validfields(p:string): bool =
  result = false
  var fields = p.split(" ")
  var k,v:string
  for f in fields:
    (k,v) = f.split(':')
    case k:
      # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
      of "ecl:":
        if not (v in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]):
          # echo f
          return
      # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
      of "hcl:":
        if not (v.match(re"#[0-9a-f]{6}")): 
          # echo f
          return
      # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
      of "eyr:":
        if v.len != 4:
          echo v
          return
        var eyr = v.parseInt
        if not ((eyr >= 2020) and (eyr <= 2030)):
          # echo f 
          return
      # pid (Passport ID) - a nine-digit number, including leading zeroes.
      of "pid:":
        if not (v.match(re"[0-9]{9}")): 
          # echo f
          return
      # byr (Birth Year) - four digits; at least 1920 and at most 2002.
      of "byr:":
        if v.len != 4:
          echo v
          return
        var byr = v.parseInt
        if not ((byr >= 1920) and (byr <= 2002)): 
          # echo f
          return
      # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
      of "iyr":
        if v.len != 4:
          echo v
          return
        var iyr = v.parseInt
        if not ((iyr >= 2010) and (iyr <= 2020)): 
          # echo f
          return
      # hgt (Height) - a number followed by either cm or in:
      of "hgt":
        case f[^2..^1]:
          # If cm, the number must be at least 150 and at most 193.
          of "cm":
            var cm = f[4..^3].parseInt
            if not ((cm >= 150) and (cm <= 193)): 
              # echo f
              return
          # If in, the number must be at least 59 and at most 76.
          of "in":
            var inch = f[4..^3].parseInt
            if not ((inch >= 59) and (inch <= 76)): 
              # echo f
              return
          else: 
            # echo f
            return
      # cid (Country ID) - ignored, missing or not.
  return true

proc part1(fn:string):int =
  var data = fn.parseFile
  for d in data:
    if validPassport(d): result.inc

proc part2(fn:string):int =
  result = 0
  var data = fn.parseFile
  for d in data:
    if validPassport(d):
      if validFields(d):
        # echo d
        # echo ""
        result.inc

# part 1 = 206
# 18:28 = start part 2
# 19:43 130 is too high
# 19:54 132 is too high




# echo "example".part1()
echo "input".part1()

echo "input".part2()
