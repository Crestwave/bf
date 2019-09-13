# bf.js

A brainfuck interpreter written in JavaScript using pure Node.js

## Info
- It reads the program from a file named in the first argument
    - If there are no arguments, it reads from standard input
- An array with cells from -200 to 30000 is initialized
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded

## bf2.js Info

- The program is transpiled into JavaScript then evaluated
- An array of 30,000 cells is initialized
	- Negative pointers refer to cells from the end of the array
