#!/usr/bin/env ruby
program = ARGF.read
program.gsub!(/[^><+\-.,\[\]]/, '')

stack = []
jumps = []

program.each_char.with_index do |c, i|
  if c == '['
    stack.push(i)
  elsif c == ']'
    j = stack.pop
    jumps[i] = j
    jumps[j] = i
  end
end

len = program.length
tape = Hash.new(0)
ptr = 0
i = 0

while i < len
  case program[i]
  when '>'
    ptr += 1
  when '<'
    ptr -= 1
  when '+'
    tape[ptr] = (tape[ptr] + 1) & 255
  when '-'
    tape[ptr] = (tape[ptr] - 1) & 255
  when '.'
    putc tape[ptr].chr
  when ','
    tape[ptr] = $stdin.getbyte unless $stdin.eof?
  when '['
    i = jumps[i] if tape[ptr].zero?
  when ']'
    i = jumps[i] if tape[ptr].nonzero?
  end
  i += 1
end
