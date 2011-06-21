SWIG?=swig

copy_files: xfsm_wrap.c Privates.pm
	cp xfsm_wrap.c ../privates
	cp Privates.pm ../lib/Lingua/XFST

xfsm_wrap.c Privates.pm: xfsm.i
	$(SWIG) -perl5 -const -I../privates xfsm.i
