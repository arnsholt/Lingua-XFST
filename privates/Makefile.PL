use ExtUtils::MakeMaker;
WriteMakefile(
    NAME => 'Lingua::XFST::Privates',
    INST_LIB => '../blib/lib',
    INST_ARCHLIB => '../blib/arch',
    LIBS => "-L$ENV{HOME}/sw/lib -lxfsm",
    OBJECT => 'xfsm_wrap.o',
);
