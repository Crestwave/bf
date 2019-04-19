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
    ',' => '$c = getc and $a[$p] = ord($c)',
    '[' => 'while ($a[$p]) {',
    ']' => '}',
);

local $| = 1;
local $/;
local $_ = <>;
die $! unless defined;
s/[^><+-.,[\]]//g;
s/./$translation{$&};/g;
eval;
die $@ if $@;
