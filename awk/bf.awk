#!/usr/bin/awk -f

BEGIN {
    ptr = counter = 0
    input = ""
    for (i = 0; i <= 30000; ++i)
        tape[i] = 0
    for (i = 0; i < 256; ++i)
        ord[sprintf("%c", i)] = i
}

{
    gsub(/[^><+-\.,[\]]/, "")
    program = program $0
}

END {
    len = length(program)
    for (i = 1; i <= len; ++i) {
        c = substr(program, i, 1)

        if (c == ">") {
            ++ptr
        } else if (c == "<") {
            --ptr
        } else if (c == "+") {
            ++tape[ptr]
            if (tape[ptr] > 255) tape[ptr] = 0
        } else if (c == "-") {
            --tape[ptr]
            if (tape[ptr] < 0) tape[ptr] = 255
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
            if (tape[ptr]) {
                stack[counter++] = i
            } else {
                for (depth = 1; depth > 0 && ++i; ) {
                    c = substr(program, i, 1)
                    if (c == "[") {
                        ++depth
                    } else if (c == "]") {
                        --depth
                    }
                }
            }
        } else if (c == "]") {
            if (tape[ptr]) i = stack[counter - 1] - 1
            delete stack[--counter]
        }
    }
}
