#!/usr/bin/env swift
import Foundation

var program = ""

if CommandLine.argc > 1 {
    do {
        program = try String(contentsOfFile: CommandLine.arguments[1])
    } catch let error as NSError {
        let msg = "\(CommandLine.arguments[1]): \(error.localizedDescription)\n"

        FileHandle.standardError
                  .write(msg.data(using: .utf8)!)

        exit(1)
    }
} else {
    while let line = readLine() {
        program.append(line)
    }
}

program = program.filter("><+-.,[]".contains)

var jumps = Array(repeating: 0, count: program.count)
var stack: [Int] = []

for (i, c) in program.enumerated() {
    if c == "[" {
        stack.append(i)
    } else if c == "]" {
        if stack.count == 0 {
            FileHandle.standardError
                      .write("error: extraneous ']'\n".data(using: .utf8)!)

            exit(1)
        }

        let j = stack.removeLast()

        jumps[i] = j
        jumps[j] = i
    }
}

if stack.count > 0 {
    FileHandle.standardError
              .write("error: expected ']'\n".data(using: .utf8)!)

    exit(1)
}

let len = program.count

var i = 0
var line = ""
var ptr = 0
var tape = Array(repeating: 0, count: 65536)

while (i < len) {
    let c = program[program.index(program.startIndex, offsetBy: i)]

    if c == ">" {
        ptr = (ptr + 1) & 65535
    } else if c == "<" {
        ptr = (ptr - 1) & 65535
    } else if c == "+" {
        tape[ptr] = (tape[ptr] + 1) & 255
    } else if c == "-" {
        tape[ptr] = (tape[ptr] - 1) & 255
    } else if c == "." {
        print(Character(UnicodeScalar(tape[ptr])!), terminator: "")
    } else if c == "," {
        if line.count == 0 {
            let input = readLine(strippingNewline: false)

            if input != nil {
                line = input!
            }
        }

        if line.count > 0 {
            tape[ptr] = Int(UnicodeScalar(String(line
                            .remove(at: line.startIndex)))!.value)
        }
    } else if c == "[" {
        if tape[ptr] == 0 {
            i = jumps[i]
        }
    } else if c == "]" {
        if tape[ptr] != 0 {
            i = jumps[i]
        }
    }


    i += 1
}
