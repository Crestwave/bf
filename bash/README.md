# bf.bash

A brainfuck interpreter written in pure Bash

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- It only depends on Bash 4.3+ and is portable
- An array with the length of 30,000 cells is created
	- Negative pointers count from the back of the array
- Unmatched brackets are detected during runtime
- Output is ASCII-encoded


## bf2.bash Info

- The program is transpiled into Bash then evaluated
- It reads from files named in all arguments
- Negative pointers are allowed
