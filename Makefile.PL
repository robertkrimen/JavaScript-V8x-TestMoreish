use inc::Module::Install;

name     'JavaScript-V8x-TestMoreish';
all_from 'lib/JavaScript/V8x/TestMoreish.pm';
author   q{Robert Krimen <rkrimen@cpan.org>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

