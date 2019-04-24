# bf.pl

A brainfuck interpreter written in pure Ruby

## Info

- The program is transpiled into Ruby then evaluated
- An array of 30,000 cells is initialized
	- Referencing uninitialized cells is not allowed
	- Negative pointers refer to cells from the end of the array
- Output is ASCII-encoded
