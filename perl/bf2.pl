#!/usr/bin/env perl
use strict;
use warnings;
use IO::Handle;

my $program;
{
    local $/ = undef;
    do { $program .= <> } while (@ARGV);
    IO::Handle::clearerr(*STDIN);
    die $! unless defined($program);
}

$program =~ s/[^><+\-.,[\]]//g;
my $len = length($program);
my @stack;
my @jumps;

for (my $i = 0; $i < $len; ++$i) {
    my $c = substr($program, $i, 1);
    if ($c eq '[') { push @stack, $i }
    elsif ($c eq ']') {
        die "Unmatched right square bracket" unless (@stack);
        my $j = pop(@stack);
        $jumps[$j] = $i;
        $jumps[$i] = $j;
    }
}

die "Missing right square bracket" if (@stack);
local $| = 1;
my %tape;
my $ptr = 0;

for (my $i = 0; $i < $len; ++$i) {
    my $c = substr($program, $i, 1);
    if ($c eq '>') { ++$ptr }
    elsif ($c eq '<') { --$ptr }
    elsif ($c eq '+') { ++$tape{$ptr} == 256 and $tape{$ptr} = 0 }
    elsif ($c eq '-') { --$tape{$ptr} == -1 and $tape{$ptr} = 255 }
    elsif ($c eq '.') { print chr($tape{$ptr}) }
    elsif ($c eq ',') {
        unless (eof(STDIN)) { $tape{$ptr} = ord(getc) }
        else { IO::Handle::clearerr(*STDIN) }
    }
    elsif ($c eq '[') { $i = $jumps[$i] unless ($tape{$ptr}) }
    elsif ($c eq ']') { $i = $jumps[$i] if ($tape{$ptr}) }
}
