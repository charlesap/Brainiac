#  Brainiac.py

import sys


SPD = 40  # Synapses per Dendrite
PPP = 48  # Proximal per Pyramidal
BPP = 48  # Basal per Pyramidal
APP = 48  # Apical per Pyramidal
PinL2 = 32  # Pyramidal in L2
PinL4 = 32  # Pyramidal in L4
Acc4 = 32 + PinL2
PinL5 = 32  # Pyramidal in L5
Acc5 = 32 + Acc4
PinL6 = 32  # Pyramidal in L6
Acc6 = 32 + Acc5
PinTh = 4  # Pyramidal in Thalmus
AccTh = 4 + Acc6
MCinC = 128  # Minicolumns in a Column
CinP = 9  # Columns in a Patch
NP = 152064


class Dendrite:
    def __init__():
        self.s = [None for i in range(SPD)]


class Pyramidal:
    def __init__():
        self.State = 0
        self.Proximal = [Dendrite() for i in range(PPP)]
        self.Basal = [Dendrite() for i in range(BPP)]
        self.Apical = [Dendrite() for i in range(APP)]


class Minicolumn:
    def __init():
        self.L2 = [Pyramidal() for i in range(PinL2)]
        self.L4 = [Pyramidal() for i in range(PinL4)]
        self.L5 = [Pyramidal() for i in range(PinL5)]
        self.L6 = [Pyramidal() for i in range(PinL6)]
        self.Thalmus = [Pyramidal() for i in range(PinTh)]


class Column:
    def __init():
        self.MC = [Minicolumn() for i in range(MCinC)]


class Patch:
    def __init():
        self.C = [Column() for i in range(CinP)]


def la2sa(a):
    mci = a % AccTh
    mco = a // AccTh
    mc = mco % MCinC
    co = a // (AccTh * MCinC)
    c = co % CinP
    if mci < PinL2:
        lv = 0
        lvo = mci
    elif mci < Acc4:
        lv = 1
        lvo = mci - PinL2
    elif mci < Acc5:
        lv = 2
        lvo = mci - Acc4
    elif mci < Acc6:
        lv = 3
        lvo = mci - Acc5
    elif mci < AccTh:
        lv = 4
        lvo = mci - Acc6
    else:
        lv = -1
        lvo = -1
    return c, mc, lv, lvo


def initialize():

    P = None
    if len(sys.argv) > 1:
        print(f"  initializing {sys.argv[1]}")
        t = "9-128-4-32-32-32-32-48-48-48-40-0-0-0.dnd"
        dndfn = f"b-{sys.argv[1]}-{t}"
        t = "9-128-4-32-32-32-32-0-0-0.pex"
        pexfn = f"b-{sys.argv[1]}-{t}"
        try:
            with open(pexfn, "r") as fpex:
                try:
                    with open(dndfn, "r") as fdnd:
                        dp = SPD + PPP + BPP + APP

                        print(f"   dendrites:    {dp*NP}")
                        print(f"   p cells  :      {NP}")
                        print(f"   miniclmns:        {CinP*MCinC}")
                        P = Patch()
                        for i in range(NP):
                            c, mc, lv, lvo = la2sa(i)
                #        print(f"--{i} {c} {mc} {lv} {lvo}")

                except:
                    print(f"  file {dndfn}?")
        except:
            print(f"  file {pexfn}?")
    else:
        print("  parameter?")

    return P


def iterate(P):
    print("  iterating")


def summarize(P):
    print("  summarizing")


if __name__ == "__main__":
    print(" Brainiac")
    P = initialize()
    iterate(P)
    summarize(P)
