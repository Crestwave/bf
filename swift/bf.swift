#!/usr/bin/env swift

/*
let line = readLine(strippingNewline: false)
if line != nil {
    let l = line!
    let c = l[l.index(l.startIndex, offsetBy: 0)]
    print(c)
    print(l, terminator: "")
    //print(l)
    //print(line![line!.index(line!.startIndex, offsetBy: 0)])
} else {
    print("EOF")
}
*/


var program = ""
while let line = readLine() {
    program.append(line)
}
//var program = ",[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>>+++++[<----->-]<<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>>+++++[<----->-]<<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]>.[-]<,][..]"
//print(program)
//print(program.characters.count)
//var jumps: [Int] = []
var jumps = Array(repeating: 0, count: program.characters.count)
var stack: [Int] = []
//program.characters.enumerated().forEach { print($0, ":", $1) }
//jumps.reserveCapacity(program.characters.count)
//stack.reserveCapacity(program.characters.count)

for (i, c) in program.characters.enumerated() {
    if c == "[" {
        stack.append(i)
    } else if c == "]" {
        let j = stack.removeLast()
        //jumps.insert(i, at: j)
        jumps[i] = j
        jumps[j] = i
        //jumps.insert(j, at: i)
        //print(j, ":", i)
    }
}

/*
for (i, c) in jumps.enumerated() {
    print(i, ": ", c)
}
*/

var ptr = 0
var tape = Array(repeating: 0, count: 30000)
let len = program.characters.count
var line: String = ""

//for (i, c) in program.characters.enumerated() {
//for i in stride(from: 0, to: len, by: 1) {
//for i in sequence(first: 0, next: {$0 + 1}).prefix(while: {$0 < len}) {
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
        if line.characters.count == 0 {
            let input = readLine(strippingNewline: false)
            if input != nil {
                line = input!
            }
        }
        if line.characters.count > 0 {
            //let ch = UnicodeScalar(String(line.remove(at: line.startIndex)))!.value
            //tape[ptr] = Int(ch)
            tape[ptr] = Int(UnicodeScalar(String(line.remove(at: line.startIndex)))!.value)
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
    //print(i, ":", tape[ptr])
}
//print(CommandLine.argc)
//let arguments = CommandLine.arguments
//for i in arguments {
//    print(i)
//}
