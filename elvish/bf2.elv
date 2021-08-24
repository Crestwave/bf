#!/usr/bin/env elvish
use re

prog = ""
if (> (count $args) 0) {
  up:prog = (slurp < $args[0])
} else {
  up:prog = (slurp)
}

init = '
use str

input = ""
ptr = 0
tape = [(repeat 30000 0)]
'

tr = [&'>'='ptr = (+ $ptr 1)'
      &'<'='ptr = (- $ptr 1)'
      &'+'='if (== $tape[$ptr] 255) {
              tape[$ptr] = 0
            } else {
              tape[$ptr] = (+ $tape[$ptr] 1)
            }'
      &'-'='if (== $tape[$ptr] 0) {
              tape[$ptr] = 255
            } else {
              tape[$ptr] = (- $tape[$ptr] 1)
            }' 
      &'.'='print (str:from-codepoints $tape[$ptr])'
      &','='if (== (count $input) 0) {
              input = (read-upto "\n")
            }

            if (> (count $input) 0) {
              tape[$ptr] = (str:to-codepoints $input[0])
              input = $input[1:]
            }'
      &'['='while (!= $tape[$ptr] 0) {'
      &']'='}']

prog = $init(
re:replace '.?' [c]{
    if (has-key $tr $c) {
      put $tr[$c]"\n"
    } else {
      put ""
    }
  } $prog
)

{ eval $prog }
