#!/usr/bin/env node
const fs = require('fs');
const program = fs
    .readFileSync(process.argv[2] || 0, 'ascii')
    .replace(/[^><+\-.,[\]]/g, '');

const stack = [];
const jumps = [];

for (let i = 0; i < program.length; ++i) {
    switch (program[i]) {
    case '[':
            stack.push(i);
            break;
    case ']':
            if (!stack.length)
                throw new Error('SyntaxError: Unexpected token ]');

            let j = stack.pop();
            jumps[j] = i;
            jumps[i] = j;
            break;
    }
}

if (stack.length)
    throw new Error('SyntaxError: Expecting token ]');

const tape = new Uint8Array(65536);
const ptr = new Uint16Array(1);

for (let i = 0; i < program.length; ++i)
    switch (program[i]) {
        case '>':
            ++ptr[0];
            break;
        case '<':
            --ptr[0];
            break;
        case '+':
            ++tape[ptr[0]];
            break;
        case '-':
            --tape[ptr[0]];
            break;
        case '.':
            process.stdout.write(String.fromCharCode(tape[ptr[0]]));
            break;
        case ',':
            let buf = new Int8Array(1)
            if (fs.readSync(0, buf, 0, 1))
                tape[ptr[0]] = buf[0];
            break;
        case '[':
            if (!tape[ptr[0]])
                i = jumps[i];
            break;
        case ']':
            if (tape[ptr[0]])
                i = jumps[i];
            break;
    }
