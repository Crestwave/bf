#!/usr/bin/env node
const fs = require('fs');
const program = fs
    .readFileSync(process.argv[2] || 0, 'ascii')
    .replace(/[^><+\-.,[\]]/g, '');
const len = program.length;

let stack = [];
let jumps = [];

for (let i = 0; i < len; ++i) {
    switch (program[i]) {
    case '[':
            stack.push(i);
            break;
    case ']':
            if (!stack.length)
                throw new Error("SyntaxError: Unexpected token ]");

            let j = stack.pop();
            jumps[j] = i;
            jumps[i] = j;
            break;
    }
}

if (stack.length)
    throw new Error("SyntaxError: Expecting token ]");

let tape = [];
let ptr = 0;
for (let i = -200; i < 30000; ++i)
    tape[i] = 0;

for (let i = 0; i < len; ++i)
    switch (program[i]) {
        case '>':
            ++ptr;
            break;
        case '<':
            --ptr;
            break;
        case '+':
            tape[ptr] = tape[ptr]+1 & 255;
            break;
        case '-':
            tape[ptr] = tape[ptr]-1 & 255;
            break;
        case '.':
            process.stdout.write(String.fromCharCode(tape[ptr]));
            break;
        case ',':
            let buf = new Int8Array(1)
            if (fs.readSync(0, buf, 0, 1))
                tape[ptr] = buf[0];
            break;
        case '[':
            if (! tape[ptr])
                i = jumps[i];
            break;
        case ']':
            if (tape[ptr])
                i = jumps[i];
            break;
    }
