use inc::Module::Install;

name     'Config-INI-Reader-Ordered';
all_from 'lib/Config/INI/Reader/Ordered.pm';
author   'Hans Dieter Pearcey <hdp@cpan.org>';

build_requires 'Test::More';

requires 'Config::INI::Reader';

auto_manifest;

WriteAll;

