use std::collections::HashMap;
use std::env;
use std::fs::File;
use std::io;
use std::io::prelude::*;

fn main() -> io::Result<()> {
    let len;
    let program: Vec<char> = {
        let mut buf = String::new();
        if let Some(filename) = env::args().nth(1) {
            let mut f = File::open(filename)?;
            len = f.read_to_string(&mut buf)?;
        } else {
            let stdin = io::stdin();
            let mut handle = stdin.lock();
            len = handle.read_to_string(&mut buf)?;
        }
        buf.chars().collect()
    };

    let mut jumps = HashMap::new();
    let mut stack = Vec::new();
    for (i, c) in program.iter().enumerate() {
        if c == &'[' {
            stack.push(i);
        } else if c == &']' {
            if stack.is_empty() {
                panic!("un-closed '['");
            }
            let j = stack.pop().unwrap();
            jumps.insert(i, j);
            jumps.insert(j, i);
        }
    }

    if !stack.is_empty() {
        panic!("unexpected ']'");
    }

    let mut tape: [u8; 65536] = [0; 65536];
    let mut ptr: u16 = 0;
    let mut i = 0;
    while i < len {
        match program[i] {
            '>' => ptr += 1,
            '<' => ptr -= 1,
            '+' => tape[ptr as usize] += 1,
            '-' => tape[ptr as usize] -= 1,
            ',' => match io::stdin().bytes().next() {
                Some(Ok(c))  => tape[ptr as usize] = c,
                Some(Err(e)) => panic!(e),
                None         => (),
            },
            '.' => {
                print!("{}", tape[ptr as usize] as char);
                io::stdout().flush()?;
            },
            '[' if tape[ptr as usize] == 0 => i = jumps[&i],
            ']' if tape[ptr as usize] != 0 => i = jumps[&i],
            _ => (),
        }
        i += 1;
    }
    Ok(())
}
