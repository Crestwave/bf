# bf.c

A brainfuck interpreter written in pure C

## Info

- It is written in portable C
- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
	- It only reads up to 65,536 bytes
- An array of 65,536 cells is initialized
	- The pointer wraps on 16-bit overflow and underflow
- Output is ASCII-encoded
