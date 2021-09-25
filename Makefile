CC=gcc
FC=gfortran
OC=obnc
GC=go build
JC=javac

brainiac.c brainiac.f90 Brainiac.Mod brainiac.py Brainiac.java brainiac.go:
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

all: cbrainiac fbrainiac obrainiac gobrainiac brainiac.py Brainiac.class

clean:
	if [ -f cbrainiac ] ; then rm cbrainiac ; fi
	if [ -f fbrainiac ] ; then rm fbrainiac ; fi
	if [ -f obrainiac ] ; then rm obrainiac ; fi
	if [ -d .obnc ] ; then rm -rf .obnc ; fi
	if [ -f gobrainiac ] ; then rm gobrainiac ; fi
	rm -f *.class
	if [ -f brainiac.c ] ;    then rm brainiac.c ; fi
	if [ -f brainiac.f90 ] ;  then rm brainiac.f90 ; fi
	if [ -f Brainiac.Mod ] ;  then rm Brainiac.Mod ; fi
	if [ -f brainiac.go ] ;   then rm brainiac.go ; fi
	if [ -f brainiac.py ] ;   then rm brainiac.py ; fi
	if [ -f Brainiac.java ] ; then rm Brainiac.java ; fi

test: cbrainiac fbrainiac obrainiac gobrainiac brainiac.py Brainiac.class
	./cbrainiac cbraintest
	./fbrainiac fbraintest
	./obrainiac obraintest
	./gobrainiac gobraintest
	python3 brainiac.py pybraintest
	java Brainiac jbraintest

