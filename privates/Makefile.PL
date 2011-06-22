use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::Liblist;

my $extra_paths = join q{ }, map { "-L$_" } split m/:/, $ENV{LD_LIBRARY_PATH};
my $LIBS = (ExtUtils::Liblist->ext("$extra_paths -lxfsm", 0, 0))[2];

WriteMakefile(
    NAME => 'Lingua::XFST::Privates',
    INST_LIB => '../blib/lib',
    INST_ARCHLIB => '../blib/arch',
    LIBS => $LIBS,
    OBJECT => 'xfsm_wrap.o',
);
