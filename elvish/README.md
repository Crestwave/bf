# bf.elv

A brainfuck interpreter written in pure Elvish

## Info

- It reads from a file named in the first argument
	- If there are no arguments, it reads from standard input
- An list of 30,000 cells is initialized.
	- Negative pointers are allowed and count from the back of the list.
- Output is UTF-8-encoded

## Compatibility

- It is compatible with the one true `awk`
- It is compliant with `gawk`'s linting when portable
- Input is not supported on BusyBox's interpreter
- An array of 30,000 cells in the positive direction is initialized
	- Referencing uninitialized cells is allowed, though not portable
- Cells wrap on 8-bit overflow and underflow
- The cell is left unchanged on EOF
- Input is line buffered
- The locale's character set is used
