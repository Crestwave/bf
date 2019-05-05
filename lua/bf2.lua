#!/usr/bin/env lua

local program = ""
if #arg > 0 then
  for i = 1, #arg do
    local f = assert(io.open(arg[1], "r"))
    program = program .. f:read("*all")
    f:close()
  end
else
  program = io.read("*all")
end

program = program:gsub("[^><+%-.,[%]]", "")
local tape = setmetatable({}, {__index=function() return 0 end})
local stack = {}
local jumps = {}
local ptr = 0

for i = 1, #program do
  local c = program:byte(i)
  if c == 91 then
    ptr = ptr + 1
    stack[ptr] = i
  elseif c == 93 then
    if ptr < 1 then
      error "unmatched ']'"
    end
    jumps[stack[ptr]] = i
    jumps[i] = stack[ptr]
    ptr = ptr - 1
  end
end

if ptr > 0 then
  error "unmatched '['"
end

local i = 1
while i <= #program do
  local c = program:byte(i)
  if c == 62 then
    ptr = ptr + 1
  elseif c == 60 then
    ptr = ptr - 1
  elseif c == 43 then
    tape[ptr] = (tape[ptr]+1) % 256
  elseif c == 45 then
    tape[ptr] = (tape[ptr]-1) % 256
  elseif c == 46 then
    io.write(string.char(tape[ptr]))
    io.flush()
  elseif c == 44 then
    if io.read(0) then
      tape[ptr] = io.read(1):byte()
    end
  elseif c == 91 then
    if (tape[ptr] == 0) then
      i = jumps[i]
    end
  elseif c == 93 then
    if (tape[ptr] ~= 0) then
      i = jumps[i]
    end
  end
  i = i + 1
end
