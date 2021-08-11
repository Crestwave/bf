#!/usr/bin/env swift
import Foundation

let stderr = FileHandle.standardError
var program = ""
if CommandLine.argc > 1 {
    do {
        program = try String(contentsOfFile: CommandLine.arguments[1])
    } catch let error as NSError {
        let msg = "\(CommandLine.arguments[1]): \(error.localizedDescription)\n"
        stderr.write(msg.data(using: .utf8)!)
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
            stderr.write("error: extraneous ']'\n".data(using: .utf8)!)
            exit(1)
        }

        let j = stack.removeLast()
        jumps[i] = j
        jumps[j] = i
    }
}

if stack.count > 0 {
    stderr.write("error: expected ']'\n".data(using: .utf8)!)
    exit(1)
}

let len = program.count
var line: String = ""
var ptr = 0
var tape = Array(repeating: 0, count: 30000)

var i = 0
while (i < len) {
    let c = program[program.index(program.startIndex, offsetBy: i)]
    if c == ">" {
        ptr += 1
        if ptr == 30000 {
            ptr = 0
        }
    } else if c == "<" {
        ptr -= 1
        if ptr == -1 {
            ptr = 29999
        }
    } else if c == "+" {
        tape[ptr] += 1
        if tape[ptr] == 256 {
            tape[ptr] = 0
        }
    } else if c == "-" {
        tape[ptr] -= 1
        if tape[ptr] == -1 {
            tape[ptr] = 255
        }
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
