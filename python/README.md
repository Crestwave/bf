# bf.py

A brainfuck interpreter written in pure Python

## Info

- It is compatible with both Python 2 and 3
- It is compliant with PEP 8 and `pylint`
- It reads the program from a file named in the first argument
	- If there are no arguments, it reads from standard input
- A list of 30,000 cells is initialized
	- Negative pointers count from the back of the list
- Unmatched brackets are detected before runtime
- The Python version's default character encoding is used for output
