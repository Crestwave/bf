#!/usr/bin/env perl
use strict;
use warnings;

my @a = (0) x 30000;
my $p = 0;
my $c;
my %translation = (
    '>' => '++$p',
    '<' => '--$p',
    '+' => '++$a[$p]; $a[$p] = 0 if ($a[$p] > 255)',
    '-' => '--$a[$p]; $a[$p] = 255 if ($a[$p] < 0)',
    '.' => 'print chr($a[$p])',
    ',' => '$c = getc; $a[$p] = ord($c) if defined($c)',
    '[' => 'while ($a[$p]) {',
    ']' => '}',
);

local $| = 1;
my $program;
{
    local $/;
    $program = <>;
    die $! unless defined($program);
}
$program =~ s/[^><+-.,[\]]//g;
$program =~ s/./$translation{$&};/g;
eval $program;
die $@ if $@;
