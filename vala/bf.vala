void main (string[] args) {
    string program;

    if (args.length > 1) {
        try {
            FileUtils.get_contents (args[1], out program);
        } catch (FileError e) {
            error (e.message);
        }
    } else {
        var builder = new StringBuilder ();
        string line;
        while ((line = stdin.read_line ()) != null) {
            builder.append (line);
        }
        program = builder.str;
        stdin.clearerr ();
    }

    try {
        Regex r = new Regex ("""[^><+\-.,[\]]""");
        program = r.replace (program, program.length, 0, "");
    } catch (RegexError e) {
        error (e.message);
    }

    size_t length = program.length;
    int[] stack = new int[length];
    int[] jumps = new int[length];
    uint16 ptr = 0;

    for (int i = 0; i < length; ++i) {
        switch (program[i]) {
        case '[':
            stack[++ptr] = i;
            break;
        case ']':
            if (ptr < 1) {
                error ("expected `]'");
            }
            jumps[stack[ptr]] = i;
            jumps[i] = stack[ptr--];
            break;
        }
    }

    if (ptr > 0) {
        error ("unexpected `['");
    }

    char tape[uint16.MAX+1];
    int c;

    for (int i = 0; i < length; ++i) {
        switch (program[i]) {
        case '<':
            --ptr;
            break;
        case '>':
            ++ptr;
            break;
        case '+':
            tape[ptr] += 1;
            break;
        case '-':
            tape[ptr] -= 1;
            break;
        case '.':
            stdout.putc (tape[ptr]);
            stdout.flush ();
            break;
        case ',':
            c = stdin.getc ();
            if (stdin.eof () == false) {
                tape[ptr] = (char) c;
            } else {
                stdin.clearerr ();
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
