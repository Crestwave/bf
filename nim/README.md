# bf.nim

A brainfuck interpreter written in pure Nim

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- An array with cells from -200 to 29999 is initialized
    - Negative pointers are allowed
- Brackets can only be parsed up to the 65536th byte
- Unmatched brackets are detected before runtime
- Output is ASCII-encoded
