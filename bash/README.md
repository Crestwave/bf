# bf.bash

A brainfuck interpreter written in pure Bash

## Info

- It reads from a file named in the first argument
	- If there are no arguments, it reads from standard input
- It only depends on Bash 4+ and is portable
	- A patch for Bash 3.2+ support is also available
		- It reads from `/dev/stdin` if there are no arguments
		- It cannot decrement the pointer below zero
- It does not optimize on specific patterns
- Unmatched brackets are detected during runtime
- Negative pointers are allowed
- Output is ASCII-encoded
