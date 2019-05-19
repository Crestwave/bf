# bf.cr

A brainfuck interpreter written in pure Crystal

## Info

- An array of 300,000 cells is initialized
    - Negative pointers refer to cells from the end of the array
- Unmatched brackets are detected before runtime
- Output is UTF-8-encoded
