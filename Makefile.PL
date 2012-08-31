use inc::Module::Install;
name 'Plack-Middleware-DaisukeLog';
all_from 'lib/Plack/Middleware/DaisukeLog.pm';
readme_from 'lib/Plack/Middleware/DaisukeLog.pm';
readme_markdown_from 'lib/Plack/Middleware/DaisukeLog.pm';
githubmeta;

requires 'parent';
requires 'Plack::Middleware::AccessLog';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
