import std/monotimes, os, strutils, terminal, times

let start = getMonoTime()
let cmd = commandLineParams().join(" ")
let exitCode = execShellCmd(cmd)
let elapse = getMonoTime() - start

let color = if exitCode == 0: fgGreen else: fgRed
styledEcho color, "run time = " & $elapse
