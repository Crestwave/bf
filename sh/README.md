# bf.sh

A brainfuck interpreter written in pure sh

## Info

- It is 100% POSIX compliant
	- While `[` and `printf` are not mandatory POSIX built-ins, they are mandatory external utilities
- It reads the program line by line from a file named in the first argument
	- If no arguments are passed, it reads from standard input
- Negative pointers are allowed
- Output is ASCII-encoded
