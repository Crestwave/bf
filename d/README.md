# bf.d

A brainfuck interpreter written in pure D

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The pointer is a 16-bit unsigned integer
- Unmatched brackets are detected before runtime
- Output is ASCII-encoded
