use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'  => 'XFSM',
    'LIBS'    => [],
    'OBJECT' => 'xfsm.o xfsm_wrap.o'
);
