# bf.tcl

A brainfuck interpreter written in pure Tcl

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- Unmatched brackets are detected during runtime
- Negative pointers are allowed
- The locale's character set is used
