#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

use Config::Constants perl => 't/conf2.pl';

eval "use t::lib::Foo::Bar";
like($@, qr/^Unchecked constants found in config for 'Foo\:\:Bar' \-\> \(BAM\)/, '... got the right error');