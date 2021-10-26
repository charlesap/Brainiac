#  Brainiac.py                                           
                                                         
import sys                                               
import numpy as np                                       
                                                         
                                                         
PYRAMIDAL = 0                                            
INHIBITOR = 1                                            
SPD = 40   # Synapses per Dendrite                       
DSZ = 40 * 4 # 32 bits per Synapse                       
PPP = 32   # Proximal per Pyramidal                      
BPP = 32   # Basal per Pyramidal                         
APP = 32   # Apical per Pyramidal                        
DPN = 32 + 32 + 32                                       
PinL2 = 28   # Pyramidal in L2                           
Acc2  = 28                                               
PinL4 = 28   # Pyramidal in L4                           
Acc4  = 28 + PinL2                                       
PinL5 = 28   # Pyramidal in L5                           
Acc5  = 28 + Acc4                                        
PinL6 = 28   # Pyramidal in L6                           
Acc6  = 28 + Acc5                                        
PinTh = 4    # Pyramidal in Thalmus                      
AccTh = 4  + Acc6                                        
MCinC = 96   # Minicolumns in a Column                   
CinP = 9    # Columns in a Patch                         
NP = 100224                                              
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
class Neuron:                                            
  def __init__(self,p,fpex,fdnd):                        
    data = fpex.read(2)                                  
    self.Kind  =   int.from_bytes(data, "little")        
    data = fpex.read(2)                                  
    self.State =   int.from_bytes(data, "little")        
                                                         
                                                         
    data = fdnd.read(4*SPD*DPN)                          
    self.De=np.frombuffer(data, dtype=np.int32)          
                                                         
                                                         
                                                         
                                                         
class Minicolumn:                                        
 def __init__(self,mc,fpex,fdnd):                        
  self.N=[   Neuron(p,fpex,fdnd) for p in range(AccTh)]  
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
class Column:                                            
 def __init__(self,c,fpex,fdnd):                         
  self.MC=[Minicolumn(m,fpex,fdnd) for m in range(MCinC)]
                                                         
                                                         
                                                         
                                                         
                                                         
class Patch:                                             
  def __init__(self,fpex,fdnd):                          
    self.C = [Column(c,fpex,fdnd) for c in range(CinP)]  
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
def la2sa( a ):                                          
  ni=a % AccTh                                           
  mco = a // AccTh;       mc = mco % MCinC               
  co = a // (AccTh*MCinC); c= co % CinP                  
  if        ni<PinL2:   lv=0;   lvo= ni                  
  elif      ni<Acc4:    lv=1;   lvo= ni-PinL2            
  elif      ni<Acc5:    lv=2;   lvo= ni-Acc4             
  elif      ni<Acc6:    lv=3;   lvo= ni-Acc5             
  elif      ni<AccTh:   lv=4;   lvo= ni-Acc6             
  else:                 lv=-1;  lvo=-1                   
  return c, mc, ni, lv, lvo                              
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
def initialize():                                        
                                                         
  P = None                                               
  if len(sys.argv) > 1:                                  
    print(f"  initializing {sys.argv[1]}")               
    t="9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd"         
    dndfn=f"b-{sys.argv[1]}-{t}"                         
    t="9-96-4-28-28-28-28-0-0-0.pex"                     
    pexfn=f"b-{sys.argv[1]}-{t}"                         
    try:                                                 
      with open(pexfn,'br') as fpex:                     
        try:                                             
          with open(dndfn,"br") as fdnd:                 
            dp=SPD+PPP+BPP+APP                           
                                                         
            print(f"   dendrites:    {dp*NP}")           
            print(f"   p cells  :      {NP}")            
            print(f"   miniclmns:         {CinP*MCinC}") 
            print(f"   loading...")                      
            P = Patch(fpex,fdnd)                         
                                                         
          # for i in range(NP):                          
          #   c,mc,ni,lv,lvo=la2sa(i)                    
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
          #   print(f"--{i} {c} {mc} {ni} {lv} {lvo}")   
                                                         
                                                         
                                                         
        except Exception as e: print(e)                  
                                                         
    except Exception as e: print(e)                      
                                                         
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
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
