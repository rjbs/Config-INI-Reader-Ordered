#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Config::INI::Reader::Ordered' );
}

diag( "Testing Config::INI::Reader::Ordered $Config::INI::Reader::Ordered::VERSION, Perl $], $^X" );
