# bf.dart

A brainfuck interpreter written in pure Dart

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The pointer wraps on 16-bit overflow and underflow
- Output is UTF-8-encoded
