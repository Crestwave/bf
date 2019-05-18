import os
import tables

proc parse_jumps(program: string): object =
  var
    stack = newSeq[int]()
    jumps = initCountTable[int]()

  for i, c in pairs(program):
    if c == '[':
      stack.add(i)
    elif c == ']':
      if stack.len == 0:
        quit("] without a corresponding [")

      var j = pop(stack)
      jumps[i] = j
      jumps[j] = i

  if stack.len > 0:
    quit("[ without a corresponding ]")

  result = jumps

{.push overflowChecks: off.}
proc execute_bf(program: string) =
  let
    jumps = parse_jumps(program)
    programLen = len(program)

  var
    tape: array[-200..299999, char]
    dataPtr = 0
    i = 0

  while i < programLen:
    case program[i]
    of '>': inc(dataPtr)
    of '<': dec(dataPtr)
    of '+': inc(tape[dataPtr])
    of '-': dec(tape[dataPtr])
    of '.':
      stdout.write(tape[dataPtr])
      flushFile(stdout)
    of ',':
      if not endOfFile(stdin):
        tape[dataPtr] = readChar(stdin)
    of '[':
      if tape[dataPtr] == '\0':
        i = jumps[i]
    of ']':
      if tape[dataPtr] != '\0':
        i = jumps[i]
    else: discard
    inc i
{.pop.}

when isMainModule:
  var program: string
  try:
    program = if paramCount() > 0: paramStr(1).readFile
              else: stdin.readAll
  except IOError:
    quit("I/O error: " & getCurrentExceptionMsg())

  execute_bf(program)
