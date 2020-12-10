# build lua.exe luac.exe from src --> http://lua-users.org/wiki/BuildingLuaInWindowsForNewbies
import os, strformat

# make sure script in same file with MakeFile
discard execShellCmd("mingw32-make PLAT=mingw")

createDir("d:/lua/bin")
createDir("d:/lua/include")
copyDir("doc", "d:/lua/doc")

for f in ["lua.exe", "luac.exe", "lua54.dll"]:
  let src = fmt"src/{f}"
  let target = fmt"d:/lua/bin/{f}"
  copyFile(src, target)
for f in ["luaconf.h", "lua.h", "lualib.h", "lauxlib.h", "lua.hpp"]:
  let src = fmt"src/{f}"
  let target = fmt"d:/lua/include/{f}"
  copyFile(src, target)
