#use inc::Module::Install;
#
#name 'XFSM';
#author 'Arne Skjærholt <arnsholt@gmail.com>';
#version '0.0.1';
#license 'perl';
#
#tests 't/*';
#test_requires 'Test::More' => 0;

#requires_external_cc;
#cc_files 'xfsm.c', 'xfsm_wrap.c';
#libs "-L$ENV{HOME}/sw/lib -lxfsm";

#WriteMakefile(
#    'NAME'  => 'XFSM',
#    'LIBS'    => ["-L${HOME}/sw/lib -lxfsm"],
#    'OBJECT' => 'xfsm.o xfsm_wrap.o'
#);

#WriteAll;
use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'XFSM',
    AUTHOR => 'Arne Skjærholt',
    DIR => [qw/privates/],
    VERSION_FROM => 'lib/XFSM.pm'
);
