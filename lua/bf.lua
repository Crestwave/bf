#!/usr/bin/env lua

local program
if arg[1] then
  local f = assert(io.open(arg[1], "r"))
  program = f:read("*all")
  f:close()
else
  program = io.read("*all")
end

local load = load
if not pcall(load, "") then
  load = loadstring
end

assert(load(
  "local a = setmetatable({}, {__index=function() return 0 end}) " ..
  "local p = 0 " ..
  program:gsub(".", setmetatable({
    [">"] = "p = p + 1 ",
    ["<"] = "p = p - 1 ",
    ["+"] = "a[p] = (a[p]+1) % 256 ",
    ["-"] = "a[p] = (a[p]-1) % 256 ",
    ["."] = "io.write(string.char(a[p])) io.flush() ",
    [","] = "if io.read(0) then a[p] = io.read(1):byte() end ",
    ["["] = "while a[p] ~= 0 do ",
    ["]"] = "end "
  }, {__index = function() return "" end}))
))()
