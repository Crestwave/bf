# bf.lua

A brainfuck interpreter written in pure Lua

## Info

- It is compatible with Lua 5.1+ and LuaJIT
- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The program is transpiled into Lua then evaluated
- Negative pointers are allowed
- Output is ASCII-encoded
