#!/usr/bin/env ruby
a = Array.new(30_000, 0)
p = 0
translation = {
  '>' => 'p += 1;',
  '<' => 'p -= 1;',
  '+' => 'a[p] = a[p]+1 & 255;',
  '-' => 'a[p] = a[p]-1 & 255;',
  '.' => 'putc a[p].chr;',
  ',' => 'a[p] = STDIN.getbyte unless STDIN.eof;',
  '[' => 'while a[p].nonzero? do ',
  ']' => 'end;'
}

eval ARGF.read.gsub(/./, translation)
