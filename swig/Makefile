copy_files: xfsm_wrap.c Privates.pm ../lib/XFSM
	cp xfsm_wrap.c ../privates
	cp Privates.pm ../lib/XFSM

xfsm_wrap.c Privates.pm: xfsm.i
	swig -perl5 -const -I../privates xfsm.i

../lib/XFSM:
	mkdir -p ../lib/XFSM
