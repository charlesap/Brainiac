CC=gcc
FC=gfortran
OC=obnc
GC=go build
JC=javac

brainiac.c brainiac.f90 Brainiac.Mod src/brainiac/brainiac.py Brainiac.java brainiac.go: brainiac.poly
	bash poly-extract.sh

cbrainiac: brainiac.c
	$(CC) -o cbrainiac brainiac.c 

fbrainiac: brainiac.f90
	$(FC) -Og -std=f95 -fall-intrinsics -o fbrainiac brainiac.f90

obrainiac: Brainiac.Mod
	$(OC) -o obrainiac Brainiac.Mod

gobrainiac: brainiac.go
	$(GC) -o gobrainiac brainiac.go

Brainiac.class: Brainiac.java
	$(JC) Brainiac.java

all: cbrainiac fbrainiac obrainiac gobrainiac src/brainiac/brainiac.py Brainiac.class

clean:
	rm -f cbrainiac 
	rm -f fbrainiac 
	rm -f obrainiac 
	rm -rf .obnc 
	rm -f gobrainiac 
	rm -f *.class
#	rm -f brainiac.c  brainiac.f90  Brainiac.Mod  brainiac.go  brainiac.py  Brainiac.java

test: cbrainiac fbrainiac obrainiac gobrainiac src/brainiac/brainiac.py Brainiac.class tests/commontest
	./cbrainiac tests/commontest
	./fbrainiac tests/commontest
	./obrainiac tests/commontest
	./gobrainiac tests/commontest
	python3 src/brainiac/brainiac.py tests/commontest
	java Brainiac tests/commontest

distclean:
	rm -rf dist

dist: __init__.py LICENSE pyproject.toml README.md setup.cfg src/brainiac/brainiac.py
	python3 -m build

upload: 
	python3 -m twine upload --repository pypi dist/*

patchbump: version
	bash patchbump.sh
	
