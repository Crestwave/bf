# bf.rs

A brainfuck interpreter written in pure Rust

## Info

- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- The pointer is a 16-bit unsigned integer
- Cells are 8-bit unsigned integers and don't have special handling
    - This means that it will panic on overflow and underflow in debug mode
- Unmatched brackets are detected before runtime
- Output is ASCII-encoded
