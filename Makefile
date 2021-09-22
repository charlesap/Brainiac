CC=gcc

brainiac.c:
	bash poly-extract.sh

cbrainiac: brainiac.c
	$(CC) -o cbrainiac brainiac.c 

all: cbrainiac

clean:
	rm brainiac.c brainiac.py Brainiac.Mod brainiac.f


