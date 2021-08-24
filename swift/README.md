# bf.swift

A brainfuck interpreter written in pure Swift 5

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- An array of 65,536 cells is initialized
	- The pointer wraps around when it goes out of range
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded
