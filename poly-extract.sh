#!/bin/bash
rm -f brainiac.c brainiac.py Brainiac.Mod brainiac.f90 Brainiac.java brainiac.go
awk -F║ '{for(i=1;i<=NF;i++) print $i > ("data" i)}' brainiac.poly
mv data1 brainiac.c
mv data2 brainiac.py
mv data3 Brainiac.Mod
mv data4 brainiac.f90
mv data5 Brainiac.java
mv data6 brainiac.go
