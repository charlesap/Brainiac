#!/bin/bash
awk -F$'\U00002551' '{for(i=1;i<=NF;i++) print $i > ("data" i)}' main.poly
mv data1 brainiac.c
mv data2 brainiac.py
mv data3 Brainiac.Mod
mv data4 brainiac.f
