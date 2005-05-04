#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

use Config::Constants perl => 't/conf.pl';

use t::lib::Foo::Bar;
use t::lib::Bar::Baz;

is(Foo::Bar::test_BAZ(), 'Foo::Bar -> BAZ is (the coolest module ever)', '... got the right config');

is(Bar::Baz::test_FOO(), 'Bar::Baz -> FOO is (42)', '... got the right config variable');
is(Bar::Baz::test_BAR(), 'Bar::Baz -> BAR is (Foo and Baz)', '... got the right config variable');