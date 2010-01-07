#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'JavaScript::V8x::Test' );
}

diag( "Testing JavaScript::V8x::Test $JavaScript::V8x::Test::VERSION, Perl $], $^X" );
