# bf.tcl

A brainfuck interpreter written in pure Tcl

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- Unmatched brackets are detected during runtime
- An array of 30,000 cells to the right and 200 to the left is initialized
- The locale's character set is used
