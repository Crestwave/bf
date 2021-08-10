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

/*
let program: String
while var line: String? = readLine() {
    if line == nil {
        break
    }
    program += line!
}
*/
print(CommandLine.argc)
print(CommandLine.arguments)
