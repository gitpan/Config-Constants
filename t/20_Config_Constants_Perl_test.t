#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

BEGIN {
    use_ok('Config::Constants::Perl');
};

can_ok('Config::Constants::Perl', 'new');

{
    my $config = Config::Constants::Perl->new('t/conf.pl');
    isa_ok($config, 'Config::Constants::Perl');
    
    can_ok($config, 'modules');
    can_ok($config, 'constants');    
    
    is_deeply(
        [ $config->modules ],
        [ 'Foo::Bar', 'Bar::Baz' ],
        '... got the right modules');
        
    is_deeply(
        [ $config->constants('Foo::Bar') ],
        [ { 'BAZ' => 'the coolest module ever' } ],
        '... got the right constants for Foo::Bar');

    is_deeply(
        [ $config->constants('Bar::Baz') ],
        [ { 'FOO' => 42 },
          { 'BAR' => 'Foo and Baz' } ],
        '... got the right constants for Bar::Baz');
}


