#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

use t::lib::Foo::Bar;

eval "use Config::Constants perl => 't/conf2.pl'";
like($@, qr/^Unknown constant for 'Foo\:\:Bar' \-\> \(BAM\)/, '... got the right error');