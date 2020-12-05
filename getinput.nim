import httpclient, os

createDir("input")
var c = newHttpClient()
c.downloadFile("https://adventofcode.com/2020/day/5/input", "input/005")