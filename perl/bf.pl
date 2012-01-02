#!/usr/bin/env perl
use strict;
use warnings;

local $| = 1;
my @a = (0) x 30000;
my $p = 0;
my $c;
my %translation = (
    '>' => '++$p',
    '<' => '--$p',
    '+' => '$a[$p] = ($a[$p] + 1) % 256',
    '-' => '$a[$p] = ($a[$p] - 1) % 256',
    '.' => 'print chr($a[$p])',
    ',' => '$a[$p] = ord($c) if defined($c = getc)',
    '[' => 'while ($a[$p]) {',
    ']' => '}',
);

my $program;
{
    local $/ = undef;
    $program = <>;
    die $! unless defined($program);
}
$program =~ s/[^><+-.,[\]]//g;
$program =~ s/./$translation{$&};/g;
eval $program;
die $@ if $@;
