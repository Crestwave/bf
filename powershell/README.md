# bf.bash

A brainfuck interpreter written in pure PowerShell

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it read the filename from standard input
- An array with the length of 30,000 cells is created
	- Negative pointers count from the back of the array
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded
