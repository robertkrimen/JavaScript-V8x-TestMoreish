#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use JavaScript::V8;
use JavaScript::V8x::TestMoreish::JS;

my $context = JavaScript::V8::Context->new();

sub _js_eval {
    my $got = $context->eval( @_ );
    die $got if $got ne 1;
}

$context->bind_function( say => sub {
    my $say = join '', @_;
    chomp $say;
    print $say, "\n";
} );

$context->bind_function( diag => sub {
    Test::More->builder->diag( @_ );
} );

$context->bind_function( _Test_Builder_ok => sub {
    my ( $test, $name ) = @_;
    Test::More->builder->ok( $test, $name );
} );

_js_eval( JavaScript::V8x::TestMoreish::JS->yui );
_js_eval( JavaScript::V8x::TestMoreish::JS->TestMoreish );

_js_eval( <<'_END_' );

say( YAHOO.util );

function is( have, want, description ) {
    
    _TestMoreish.areSame( have, want );

}

_END_

_js_eval( <<'_END_' );

say( _TestMoreish.areSame );

diag( "Yoink!" );

is( 1, 1 );

_END_
