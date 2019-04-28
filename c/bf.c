#include <stdio.h>
#include <stdint.h>

#define MAX_CODE_SIZE 65536
unsigned char program[MAX_CODE_SIZE];
uint8_t tape[30000] = {0};
int jumps[MAX_CODE_SIZE];
int stack[MAX_CODE_SIZE];
int len;
int ptr;
int c;
int i;
FILE *f;

int main(int argc, char **argv) {
	if (argc < 2)
		f = stdin;
	else
		f = fopen(argv[1], "r");

	len = fread(program, 1, MAX_CODE_SIZE, f);

	for (i = 0; i < len && ++i;)
		switch (program[i]) {
		case '[':
			stack[++ptr] = i;
			break;
		case ']':
			jumps[stack[ptr]] = i;
			jumps[i] = stack[ptr--];
			break;
		}

	for (i = 0; i < len; ++i)
		switch (program[i]) {
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
			fflush(stdout);
			break;
		case ',':
			c = getchar();
			if (c != EOF)
				tape[ptr] = c;
			break;
		case '[':
			if (tape[ptr] == 0)
				i = jumps[i];
			break;
		case ']':
			if (tape[ptr] != 0)
				i = jumps[i];
			break;
		}

	return 0;
}
