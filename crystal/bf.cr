#!/usr/bin/env crystal
program = ARGF.gets("") || ""
len = program.size

stack = [] of Int32
jumps = {} of Int32 => Int32

program.each_char.with_index do |c, i|
  if c == '['
    stack.push(i)
  elsif c == ']'
    j = stack.pop
    jumps[i] = j
    jumps[j] = i
  end
end

tape = Array.new(300_000, 0_u8)
ptr = 0
i = 0

while i < len
  case program[i]
  when '>'
    ptr += 1
  when '<'
    ptr -= 1
  when '+'
    tape[ptr] += 1
  when '-'
    tape[ptr] -= 1
  when '.'
    print tape[ptr].chr
  when ','
    if c = STDIN.read_byte
      tape[ptr] = c
    end
  when '['
    i = jumps[i] if tape[ptr].zero?
  when ']'
    i = jumps[i] unless tape[ptr].zero?
  end
  i += 1
end
