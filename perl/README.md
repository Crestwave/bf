# bf.pl

A brainfuck interpreter written in pure Perl 5

## Info

- It is compliant with the `strict` and `warnings` pragmas
- The program is transpiled into Perl 5 and evaluated
- An array of 30,000 cells in the positive direction is initialized
	- Cells are initialized when modified
	- Printing uninitialized cells is not allowed
	- Negative pointers refer to cells from the end of the array
- Output is ASCII-encoded
