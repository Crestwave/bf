# bf.sh

A brainfuck interpreter written in pure POSIX sh + printf

## Info

- It reads line by line from a file named in the first argument
	- If an existing file is not passed, it reads from standard input
- Negative pointers are allowed
- Output is ASCII-encoded
