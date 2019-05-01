#!/usr/bin/awk -f

BEGIN {
    ptr = 0
    input = ""
    for (i = 0; i < 30000; ++i)
        tape[i] = 0
    for (i = 0; i < 256; ++i)
        ord[sprintf("%c", i)] = i
}

{
    gsub(/[^><+\-.,[\]]/, "")
    program = program $0
}

END {
    len = length(program)
    for (i = 1; i <= len; ++i) {
        c = substr(program, i, 1)
        if (c == "[") {
            stack[++ptr] = i
        } else if (c == "]") {
            jumps[stack[ptr]] = i
            jumps[i] = stack[ptr]
            delete stack[ptr--]
        }
    }

    for (i = 1; i <= len; ++i) {
        c = substr(program, i, 1)
        if (c == ">") {
            ++ptr
        } else if (c == "<") {
            --ptr
        } else if (c == "+") {
            if (++tape[ptr] == 256)
                tape[ptr] = 0
        } else if (c == "-") {
            if (--tape[ptr] == -1)
                tape[ptr] = 255
        } else if (c == ".") {
            printf("%c", tape[ptr])
        } else if (c == ",") {
            if (length(input) == 0 && getline input < "-")
                input = input "\n"
            if (length(input)) {
                tape[ptr] = ord[substr(input, 1, 1)]
                sub(/./, "", input)
            }
        } else if (c == "[") {
            if (! tape[ptr])
                i = jumps[i]
        } else if (c == "]") {
            if (tape[ptr])
                i = jumps[i]
        }
    }
}
