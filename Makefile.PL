use inc::Module::Install;

name     'JavaScript-V8x-Test';
all_from 'lib/JavaScript/V8x/Test.pm';
author   q{Robert Krimen <rkrimen@cpan.org>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

