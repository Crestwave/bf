# bf.lua

A brainfuck interpreter written in pure Lua

## Info

- It is compatible with Lua 5.1+ and LuaJIT
- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The program is transpiled into Lua then evaluated
- An array of 30,000 cells to the right and 200 to the left is initialized
- Output is ASCII-encoded

## bf2.lua Info

- `load`/`loadstring` is not used
	- Unmatched brackets are detected before runtime
- It reads from files named in all arguments
- Array cells are initialized when they are used
