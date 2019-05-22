#!/usr/bin/env dart
import 'dart:io';
import 'dart:typed_data';

void main(List<String> arguments) {
  var program;
  if (arguments.isEmpty) {
    var buffer = new StringBuffer();
    var line;
    while ((line = stdin.readLineSync()) != null) {
      buffer.write(line);
    }
    program = buffer.toString();
  } else {
    program = new File(arguments[0]).readAsStringSync();
  }

  program = program.replaceAll(RegExp(r'[^><+\-.,[\]]'), '');
  var len = program.length;
  var jumps = new List(len);
  var stack = [];

  for (var i = 0; i < len; ++i) {
    switch (program[i]) {
      case '[':
        stack.add(i);
        break;
      case ']':
        var j = stack.removeLast();
        jumps[j] = i;
        jumps[i] = j;
        break;
    }
  }

  var tape = new Uint8List(65536);
  var ptr = 0;

  for (var i = 0; i < len; ++i) {
    switch (program[i]) {
      case '>':
        ptr = ptr+1 & 65535;
        break;
      case '<':
        ptr = ptr-1 & 65535;
        break;
      case '+':
        ++tape[ptr];
        break;
      case '-':
        --tape[ptr];
        break;
      case '.':
        stdout.writeCharCode(tape[ptr]);
        break;
      case ',':
        var c = stdin.readByteSync();
        if (c != -1) {
          tape[ptr] = c;
        }
        break;
      case '[':
        if (tape[ptr] == 0) {
          i = jumps[i];
        }
        break;
      case ']':
        if (tape[ptr] != 0) {
          i = jumps[i];
        }
        break;
    }
  }
}
