# bf

Brainfuck interpreters written in pure AWK, Bash, Elvish, Perl, Python, Ruby, and `sh`

## Implementation Info

All the interpreters have the following behavior:

- Cells wrap on 8-bit overflow and underflow
- The cell is left unchanged on EOF
- Input is line buffered

Any other behavior may vary to suit the languages.
