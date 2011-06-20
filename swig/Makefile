copy_files: xfsm_wrap.c Privates.pm
	cp xfsm_wrap.c ../privates
	cp Privates.pm ../lib/Lingua/XFSM

xfsm_wrap.c Privates.pm: xfsm.i
	swig -perl5 -const -I../privates xfsm.i
