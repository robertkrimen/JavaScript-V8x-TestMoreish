package JavaScript::V8x::TestMoreish::JS;

use strict;
use warnings;

sub TestMoreish {
    <<'_END_'
[% PROCESS js/TestMoreish.js %]
_END_
}

1;
