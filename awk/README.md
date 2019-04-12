# bf.awk

A brainfuck interpreter written in pure AWK

## Info

- It is compatible with the one true `awk`
- It is compliant with `gawk`'s linting when portable
- Input is not supported on BusyBox's interpreter
- An array of 30,000 cells in the positive direction is initialized
	- Referencing uninitialized cells is allowed, though not portable
- The locale's character set is used
