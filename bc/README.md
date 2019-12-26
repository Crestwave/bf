# bf.bc

A brainfuck interpreter written in pure `bc`

## Info

This doesn't work like the other interpreters due to `bc`'s limitations.

- Each command must be translated into its ASCII codepoint
	- Each codepoint must occupy a single line
	- The program must end with 33 (`!`)
	- The program must be stripped of comments
	- The program must be redirected into the interpreter's input
- Input must be converted in the same way and given after the program
	- It must end with -1
- Output is formatted similarly to the input and would have to externally be converted to ASCII if so desired

Additionally:

- Negative pointers are not allowed
- It is POSIX-compliant except for the use of the `read()` extension.

For your convenience, `bc.sh` is provided, which accepts a program's filename as its first argument and appropriately reads and converts input and output.
