#!/usr/bin/perl

use strict;
use warnings;

use Test::More no_plan => 1;

BEGIN {

    # Config
    use_ok('Config::Constants');

        # Config/Constants
        use_ok('Config::Constants::Perl');
        use_ok('Config::Constants::XML');

};

