# bf.elv

A brainfuck interpreter written in pure Elvish

## Info

- It reads from a file named in the first argument
	- If there are no arguments, it reads from standard input
- An list of 30,000 cells is initialized.
	- Negative pointers are allowed and count from the back of the list.
- Output is UTF-8-encoded
