# bf.pl

A brainfuck interpreter written in pure Perl 5

## Info

- It is compliant with the `strict` and `warnings` pragmas
- The program is transpiled into Perl 5 then evaluated
- An array of 30,000 cells is initialized
	- Cells are initialized when modified
	- Printing uninitialized cells causes a warning
	- Negative pointers refer to cells from the end of the array
- Output is ASCII-encoded

## bf2.pl Info

- `eval` is not used
- It reads from files named in all arguments
- End-of-files are cleared from standard input
- Negative pointers are allowed
- Unmatched brackets are detected before runtime
