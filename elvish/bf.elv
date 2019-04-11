#!/usr/bin/env elvish

use re

program input = "" ""
if (> (count $args) 0) {
	up:program = (slurp < $args[0])
} else {
	up:program = (slurp)
}

program = (re:replace '[^><+--.,[\]]' "" $program)
len = (count $program)
i ptr = 0 0
tape = [(repeat 30000 0)]
stack = []

while (< $i $len) {
	c = $program[$i]
	i = (+ $i 1)

	if (eq $c ">") {
		ptr = (+ $ptr 1)
	} elif (eq $c "<") {
		ptr = (- $ptr 1)
	} elif (eq $c "+") {
		tape[$ptr] = (+ $tape[$ptr] 1)
	} elif (eq $c "-") {
		tape[$ptr] = (- $tape[$ptr] 1)
	} elif (eq $c ".") {
		print (chr $tape[$ptr])
	} elif (eq $c ",") {
		if (== (count $input) 0) {
			input = (
				elvish -c 'each [line]{
					echo $line
					exit
				}' | slurp
			)
		}

		if (> (count $input) 0) {
			tape[$ptr] = (ord $input[0])
			input = $input[1:]
		}
	} elif (eq $c "[") {
		if (!= $tape[$ptr] 0) {
			stack = [$@stack $i]
		} else {
			depth = 1
			while (> $depth 0) {
				c = $program[$i]
				i = (+ $i 1)
				if (eq $c "[") {
					depth = (+ $depth 1)
				} elif (eq $c "]") {
					depth = (- $depth 1)
				}

			}
		}
	} elif (eq $c "]") {
		if (!= 0 $tape[$ptr]) {
			i = $stack[-1]
		} else {
			stack = $stack[:-1]
		}
	}
}
