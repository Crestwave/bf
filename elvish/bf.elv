#!/usr/bin/env elvish
use re

program input = "" ""
if (> (count $args) 0) {
  up:program = (slurp < $args[0])
} else {
  up:program = (slurp)
}

program = (re:replace '[^><+\-.,[\]]' "" $program)
len = (count $program)
tape = [(repeat 30000 0)]
jumps = [(repeat $len 0)]
i ptr = 0 0
stack = []

while (< $i $len) {
  c = $program[$i]
  if (eq $c "[") {
    stack = [$@stack $i]
  } elif (eq $c "]") {
    if (== (count $stack) 0) {
      fail "unmatched ']'"
    }
    j = $stack[-1]
    stack = $stack[:-1]
    jumps[$j] = $i
    jumps[$i] = $j
  }
  i = (+ $i 1)
}
if (> (count $stack) 0) {
  fail "unmatched '['"
}

i = 0
while (< $i $len) {
  c = $program[$i]
  if (eq $c ">") {
    ptr = (+ $ptr 1)
  } elif (eq $c "<") {
    ptr = (- $ptr 1)
  } elif (eq $c "+") {
    tape[$ptr] = (+ $tape[$ptr] 1)
    if (== $tape[$ptr] 256) {
      tape[$ptr] = 0
    }
  } elif (eq $c "-") {
    tape[$ptr] = (- $tape[$ptr] 1)
    if (== $tape[$ptr] -1) {
      tape[$ptr] = 255
    }
  } elif (eq $c ".") {
    print (chr $tape[$ptr])
  } elif (eq $c ",") {
    if (== (count $input) 0) {
      input = (read-upto "\n")
    }
    if (> (count $input) 0) {
      tape[$ptr] = (ord $input[0])
      input = $input[1:]
    }
  } elif (eq $c "[") {
    if (== $tape[$ptr] 0) {
      i = $jumps[$i]
    }
  } elif (eq $c "]") {
    if (!= $tape[$ptr] 0) {
      i = $jumps[$i]
    }
  }
  i = (+ $i 1)
}
