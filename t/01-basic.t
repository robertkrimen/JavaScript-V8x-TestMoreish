#!/usr/bin/env perl

use strict;
use warnings;

use Test::Most;

plan qw/no_plan/;

use JavaScript::V8;
use JavaScript::V8x::TestMoreish::JS;

my $context = JavaScript::V8::Context->new();

sub _js_eval {
    local $@ = undef;
    $context->eval( @_ );
    die $@ if $@;
}

$context->bind_function( say => sub {
    my $say = join '', @_;
    chomp $say;
    print $say, "\n";
} );

$context->bind_function( _TestMoreish_diag => sub {
    Test::More->builder->diag( @_ );
} );

$context->bind_function( _TestMoreish_ok => sub {
    my ( $test, $name ) = @_;
    Test::More->builder->ok( $test, $name );
} );

#_js_eval( <<'_END_' );
#if (! navigator)
#    var navigator = {};

#if (! window)
#    var window = {};

#if (! window.document)
#    var document = window.document = {};

#if (! window.document.documentElement)
#    window.document.documentElement = {};

#if (! window.document.createElement)
#    window.document.createElement = function(){};

#1;
#_END_

#_js_eval( JavaScript::V8x::TestMoreish::JS->yui );
_js_eval( JavaScript::V8x::TestMoreish::JS->TestMoreish );

_js_eval( <<'_END_' );

function is( have, want, description ) {
    
    _TestMoreish.areEqual( have, want );

}

_END_

_js_eval( <<'_END_' );

//say( _TestMoreish.areSame );

//diag( "Yoink!" );

is( 1, 1 );
is( 1, 2 );
_END_
