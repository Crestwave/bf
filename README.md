# bf

A collection of brainfuck interpreters written in pure AWK, Elvish and Bash.

## Implementation Info

All the interpreters have the following behavior:

- Cells wrap on 8-bit overflow and underflow
- The cell is left unchanged on EOF
- Input is line buffered

Any other behavior varies to suit the languages.
