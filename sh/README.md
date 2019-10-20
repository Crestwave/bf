# bf.sh

A brainfuck interpreter written in pure `sh`

## bf.sh Info

- It is POSIX-compliant
- It reads the program from a file named in the first argument
	- If no arguments are passed, it reads from standard input
- Negative pointers are allowed
- Output is ASCII-encoded

# bf1.sh Info

- Same as bf.sh but optimized at the cost of readability
