CC=gcc
FC=gfortran
OC=obnc
GC=go build

brainiac.c brainiac.f90 Brainiac.Mod brainiac.py brainiac.go:
	bash poly-extract.sh

cbrainiac: brainiac.c
	$(CC) -o cbrainiac brainiac.c 

fbrainiac: brainiac.f90
	$(FC) -Og -std=f95 -o fbrainiac brainiac.f90

obrainiac: Brainiac.Mod
	$(OC) -o obrainiac Brainiac.Mod

gobrainiac: brainiac.go
	$(GC) -o gobrainiac brainiac.go

all: cbrainiac fbrainiac obrainiac gobrainiac brainiac.py

clean:
	rm cbrainiac fbrainiac obrainiac gobrainiac
	rm brainiac.c brainiac.py Brainiac.Mod brainiac.f90 brainiac.go

#test:
#	./cbrainiac cbraintest
#	./fbrainiac fbraintest
#	./obrainiac obraintest
#	./gobrainiac gobraintest
#	python3 brainiac.py pybraintest

