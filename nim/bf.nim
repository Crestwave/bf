import tables

proc parse_jumps(program: string): object =
  var
    jumps = initCountTable[int]()
    stack = newSeq[int]()

  for i, c in pairs(program):
    if c == '[':
      stack.add(i)
    elif c == ']':
      if len(stack) == 0:
        quit("] without a corresponding [")

      var j = pop(stack)
      jumps[i] = j
      jumps[j] = i

  if len(stack) > 0:
    quit("[ without a corresponding ]")

  result = jumps

{.push overflowChecks: off.}
proc execute_bf(program: string) =
  let
    jumps = parse_jumps(program)
    programLen = len(program)

  var
    i = 0
    pos = 0
    tape: array[-200..299999, char]

  while i < programLen:
    case program[i]
    of '>': inc(pos)
    of '<': dec(pos)
    of '+': inc(tape[pos])
    of '-': dec(tape[pos])
    of '.':
      stdout.write(tape[pos])
      flushFile(stdout)
    of ',':
      if not endOfFile(stdin):
        tape[pos] = readChar(stdin)
    of '[':
      if tape[pos] == '\0':
        i = jumps[i]
    of ']':
      if tape[pos] != '\0':
        i = jumps[i]
    else: discard
    inc i
{.pop.}

when isMainModule:
  import os
  var program: string

  try:
    program = if paramCount() > 0: readFile(paramStr(1))
              else: readAll(stdin)
  except IOError:
    quit("I/O error: " & getCurrentExceptionMsg())

  execute_bf(program)
