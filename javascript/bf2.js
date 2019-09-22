#!/usr/bin/env node
let program;
const fs = require('fs');
if (process.argv.length > 2)
    for (let i = 2; i < process.argv.length; ++i) {
        program += fs.readFileSync(process.argv[i], 'ascii');
    }
else
    program = fs.readFileSync(0, 'ascii');

program = program.replace(/[^><+\-.,[\]]/g, '');
const a = [];
let p = 0;
const buf = new Int8Array(1);

const translation = {
    '>': '++p;',
    '<': '--p;',
    '+': 'a[p] = (a[p]||0)+1 & 255;',
    '-': 'a[p] = (a[p]||0)-1 & 255;',
    '.': 'process.stdout.write(String.fromCharCode(a[p]));',
    ',': 'if (fs.readSync(0, buf, 0, 1)) a[p] = buf[0];',
    '[': 'while (a[p]) {',
    ']': '}'
}
program = program.replace(/./g, c => translation[c]);
eval(program);
