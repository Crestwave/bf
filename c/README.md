# bf.bash

A brainfuck interpreter written in pure C

## Info

- It is written in portable C
- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
	- It only reads up to 65,536 bytes
- An array of 30,000 cells is initialized
	- Negative pointers are allowed and count from the end of the array
- Output is ASCII-encoded
