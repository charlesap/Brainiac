CC=gcc
FC=gfortran

brainiac.c brainiac.f90:
	bash poly-extract.sh

cbrainiac: brainiac.c
	$(CC) -o cbrainiac brainiac.c 

fbrainiac: brainiac.f90
	$(FC) -std=f95 -o fbrainiac brainiac.f90

all: cbrainiac fbrainiac

clean:
	rm cbrainiac fbrainiac
	rm brainiac.c brainiac.py Brainiac.Mod brainiac.f


