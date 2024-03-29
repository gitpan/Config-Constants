#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;
use File::Spec;

use Config::Constants xml => File::Spec->catdir('t', 'confs', 'conf3.xml');

use t::lib::Foo::Bar;
use t::lib::Bar::Baz;

is(Foo::Bar::test_BAZ(), 'Foo::Bar -> BAZ is (the coolest module ever (included))', '... got the right config');

is(Bar::Baz::test_FOO(), 'Bar::Baz -> FOO is (42)', '... got the right config variable');
is(Bar::Baz::test_BAR(), 'Bar::Baz -> BAR is (Foo and Baz)', '... got the right config variable');