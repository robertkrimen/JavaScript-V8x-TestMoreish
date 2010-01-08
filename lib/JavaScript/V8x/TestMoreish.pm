package JavaScript::V8x::TestMoreish;

use warnings;
use strict;

=head1 NAME

JavaScript::V8x::TestMoreish - Allow javascript testing in Test::More tests using v8

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

=cut

use Any::Moose;

use JavaScript::V8x::TestMoreish::JS;

use JavaScript::V8;
use Path::Abstract;
use Test::Builder();
use Sub::Exporter -setup => {
    exports => [
        test_js => sub { sub { local $Test::Builder::Level = $Test::Builder::Level + 2; return __test_js( @_ ) } },
        test_js_tester => sub { sub { return __test_js_tester( @_ ) } },
        test_js_bind => sub { sub { return __test_js_bind( @_ ) } },
        test_js_eval => sub { sub { local $Test::Builder::Level = $Test::Builder::Level + 2; return __test_js_eval( @_ ) } },
    ],
    groups => {
        default => [qw/ test_js test_js_tester test_js_bind test_js_eval /],
    },
};

my $__tester;
sub __test_js_tester { return $__tester ||= __PACKAGE__->new }
sub __test_js { return __test_js_tester->test( @_ ) } 
sub __test_js_bind { return __test_js_tester->bind( @_ ) }
sub __test_js_eval { return __test_js_tester->eval( @_ ) }


has context => qw/is ro lazy_build 1/;
sub _build_context {
    return JavaScript::V8::Context->new();
}

has builder => qw/is ro lazy_build 1/;
sub _build_builder {
    require Test::More;
    return Test::More->builder;
}

sub BUILD {
    my $self = shift;

    $self->bind(
        _TestMoreish_diag => sub { Test::More->builder->diag( @_ ) },
        _TestMoreish_ok => sub { Test::More->builder->ok( @_ ) },
    );

    $self->eval( JavaScript::V8x::TestMoreish::JS->TestMoreish );
}

sub bind {
    my $self = shift;

    while( @_ ) {
        $self->context->bind_function( shift, shift );
    }
}

sub eval {
    my $self = shift;

    # TODO TryCatch?
    local $@ = undef;
    $self->context->eval( @_ );
    die $@ if $@;
}

sub test {
    my $self = shift;

    local $Test::Builder::Level = $Test::Builder::Level + 2;

    for ( @_ ) {
        if (m/\n/) {
            $self->eval( $_ );
        }
        else {
            my $path = Path::Abstract->new( $_ );
            my $file = $path->file;
            $self->eval( scalar $file->slurp );
        }
    }
}

=head1 AUTHOR

Robert Krimen, C<< <rkrimen at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-javascript-v8x-test at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=JavaScript-V8x-TestMoreish>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc JavaScript::V8x::TestMoreish


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=JavaScript-V8x-TestMoreish>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/JavaScript-V8x-TestMoreish>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/JavaScript-V8x-TestMoreish>

=item * Search CPAN

L<http://search.cpan.org/dist/JavaScript-V8x-TestMoreish/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Robert Krimen.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of JavaScript::V8x::TestMoreish
