#!perl -T

use Test::More tests => 3;

use Devel::OnDestruct;

my (@array, %hash);

on_destruct my $var, sub { ok(1, "Scalar got destroyed!") };
on_destruct @array, sub { ok(1, "Array got destroyed!") };
on_destruct %hash, sub { ok(1, "hash got destroyed!") };
