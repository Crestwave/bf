# bf

Brainfuck interpreters written in pure AWK, Bash, Elvish, Lua, Perl, Python, Ruby, Tcl, and `sh`

## Implementation Info

All the interpreters have the following behavior:

- Cells wrap on 8-bit overflow and underflow
- The cell is left unchanged on EOF
- Input is line buffered

Any other behavior may vary to suit the languages.
