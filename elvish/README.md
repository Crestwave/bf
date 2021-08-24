# bf.elv

A brainfuck interpreter written in pure Elvish

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- A list of 30,000 cells is initialized
	- Negative pointers count from the back of the list
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded

# bf2.elv Info

- The program is transpiled into Elvish then evaluated
