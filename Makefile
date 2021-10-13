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

Brainiac.jar: Brainiac.class
	jar cfe Brainiac.jar Brainiac *.class

all: cbrainiac fbrainiac obrainiac gobrainiac src/brainiac/brainiac.py Brainiac.jar

clean:
	rm -f cbrainiac 
	rm -f fbrainiac 
	rm -f obrainiac 
	rm -rf .obnc 
	rm -f gobrainiac 
	rm -f *.class
	rm -f Brainiac.jar
	rm -f brainiac.c  brainiac.f90  Brainiac.Mod  brainiac.go  src/brainiac/brainiac.py  Brainiac.java

test: cbrainiac fbrainiac obrainiac gobrainiac src/brainiac/brainiac.py Brainiac.jar tests/commontest
	cd tests; ../cbrainiac foo > x.output; diff x.output commontest.output
	cd tests; ../fbrainiac foo > x.output; diff x.output commontest.output
	cd tests; ../obrainiac foo > x.output; diff x.output commontest.output
	cd tests; ../gobrainiac foo > x.output; diff x.output commontest.output
	cd tests; python3 ../src/brainiac/brainiac.py foo > x.output; diff x.output commontest.output
	cd tests; java -jar ../Brainiac.jar foo > x.output; diff x.output commontest.output
	

memusage: cbrainiac fbrainiac obrainiac gobrainiac src/brainiac/brainiac.py Brainiac.class tests/commontest
	@echo -n "c "; memusage ./cbrainiac tests/commontest 2>&1 | grep peak | awk '{print $$9;}'
	@echo -n "f "; memusage ./fbrainiac tests/commontest 2>&1 | grep peak | awk '{print $$9;}'
	@echo -n "o "; memusage ./obrainiac tests/commontest 2>&1 | grep peak | awk '{print $$9;}'
	@echo -n "p "; memusage python3 src/brainiac/brainiac.py tests/commontest 2>&1 | grep peak | awk '{print $$9;}'
	@echo -n "j "; memusage java Brainiac tests/commontest 2>&1 | grep peak | awk '{print $$9;}'

distclean:
	rm -rf dist

dist: __init__.py LICENSE pyproject.toml README.md setup.cfg src/brainiac/brainiac.py
	python3 -m build

upload: 
	python3 -m twine upload --repository pypi dist/*

patchbump: version
	bash patchbump.sh
	
