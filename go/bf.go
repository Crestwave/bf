package main

import (
	"bufio"
	"fmt"
	"io"
	"io/ioutil"
	"os"
)

func main() {
	var program []byte
	var err error
	if len(os.Args) > 1 {
		program, err = ioutil.ReadFile(os.Args[1])
		if err != nil {
			fmt.Fprintf(os.Stderr, "%s\n", err)
			os.Exit(1)
		}
	} else {
		program, err = ioutil.ReadAll(os.Stdin)
		if err != nil {
			panic(err)
		}
	}

	jumps := make(map[int]int)
	var stack []int

	for i, c := range program {
		switch c {
		case '[':
			stack = append(stack, i)
		case ']':
			l := len(stack)
			if l < 1 {
				panic("syntax error: expecting ]")
			}

			j := stack[l-1]
			stack = stack[:l-1]
			jumps[i] = j
			jumps[j] = i
		}
	}

	if len(stack) > 0 {
		panic("syntax error: unexpected ]")
	}

	var ptr uint16
	var tape [65536]uint8

	reader := bufio.NewReader(os.Stdin)
	l := len(program)
	for i := 0; i < l; i++ {
		switch program[i] {
		case '>':
			ptr++
		case '<':
			ptr--
		case '+':
			tape[ptr]++
		case '-':
			tape[ptr]--
		case ',':
			c, err := reader.ReadByte()
			if err == nil {
				tape[ptr] = c
			} else if err != io.EOF {
				panic(err)
			}
		case '.':
			fmt.Printf("%c", tape[ptr])
		case '[':
			if tape[ptr] == 0 {
				i = jumps[i]
			}
		case ']':
			if tape[ptr] != 0 {
				i = jumps[i]
			}
		}
	}
}
