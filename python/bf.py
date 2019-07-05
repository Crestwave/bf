#!/usr/bin/env python
"""A brainfuck interpreter written in pure Python"""
import re
import sys


def parse_jumps(program):
    """Returns a dictionary matching bracket locations"""
    index = 0
    stack = []
    jumps = {}

    for index, char in enumerate(program):
        if char == '[':
            stack.append(index)
        elif char == ']':
            if not stack:
                raise SyntaxError("unmatched closing bracket")
            match = stack.pop()
            jumps[match] = index
            jumps[index] = match

    if stack:
        raise SyntaxError("unmatched opening bracket")

    return jumps


def execute_bf(program):
    """Executes a brainfuck program"""
    jumps = parse_jumps(program)
    length = len(program)
    tape = [0] * 30000
    ptr = 0
    index = 0

    while index < length:
        char = program[index]

        if char == '>':
            ptr += 1
        elif char == '<':
            ptr -= 1
        elif char == '+':
            tape[ptr] = tape[ptr]+1 & 255
        elif char == '-':
            tape[ptr] = tape[ptr]-1 & 255
        elif char == '.':
            sys.stdout.write(chr(tape[ptr]))
            sys.stdout.flush()
        elif char == ',':
            char = sys.stdin.read(1)
            if char:
                tape[ptr] = ord(char)
        elif char == '[':
            if tape[ptr] == 0:
                index = jumps[index]
        elif char == ']':
            if tape[ptr] != 0:
                index = jumps[index]

        index += 1


def main():
    """Reads the program, strips comments from it, then runs execute_bf"""
    if sys.argv[1:]:
        with open(sys.argv[1], 'r') as program_file:
            program = program_file.read()
    else:
        program = sys.stdin.read()

    program = re.sub(r"[^><+\-.,[\]]", '', program)
    execute_bf(program)


if __name__ == "__main__":
    main()
