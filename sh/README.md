# bf.sh

A brainfuck interpreter written in pure sh

## Info

- It is 100% POSIX compliant
	- While `[` and `printf` are not mandatory POSIX built-ins, they are mandatory external utilities
- It reads line by line from a file named in the first argument
	- If an existing file is not passed, it reads from standard input
- Negative pointers are allowed
- Output is ASCII-encoded
