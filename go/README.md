# bf.go

A brainfuck interpreter written in pure Go

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The pointer is a 16-bit unsigned integer
- An array with 8-bit unsigned cells is initialized
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded
