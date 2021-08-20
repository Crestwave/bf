import std.array : back, empty, popBack;
import std.file : FileException, read;
import std.regex : regex, replaceAll;
import std.stdio : EOF, getchar, putchar, stdin, stdout, writeln;

int main(in string[] args)
{
    char[] program;
    if (args.length > 1)
        try
        {
            program = cast(char[]) read(args[1]);
        }
        catch (FileException e)
        {
            writeln(e.msg);
            return 1;
        }
    else
        stdin.readf("%s", program);

    auto re = regex(r"[^><\+\-.,\[\]]");
    program = program.replaceAll(re, "");
    size_t len = program.length;

    size_t[size_t]jumps;
    size_t[] stack;

    foreach (i, c; program)
        if (c == '[')
        {
            stack ~= i;
        }
        else if (c == ']')
        {
            if (stack.empty)
                throw new Exception("unmatched ']'");

            size_t j = stack.back;
            stack.popBack();
            jumps[i] = j;
            jumps[j] = i;
        }

    if (!stack.empty)
        throw new Exception("unmatched '['");

    char[65536] tape = '\0';
    ushort ptr;

    for (size_t i = 0; i < len; ++i)
        switch (program[i])
        {
            case '>':
                ++ptr;
                break;
            case '<':
                --ptr;
                break;
            case '+':
                ++tape[ptr];
                break;
            case '-':
                --tape[ptr];
                break;
            case '.':
                putchar(tape[ptr]);
                stdout.flush();
                break;
            case ',':
                int c = getchar();
                if (c != EOF) {
                    tape[ptr] = cast(char)c;
                } else {
                    stdin.clearerr();
                }
                break;
            case '[':
                if (!tape[ptr])
                    i = jumps[i];
                break;
            case ']':
                if (tape[ptr])
                    i = jumps[i];
                break;
            default:
                break;
        }

    return 0;
}
