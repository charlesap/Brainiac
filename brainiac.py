#  Brainiac.py                                           
                                                         
import sys                                               
                                                         
                                                         
                                                         
SPD = 40   # Synapses per Dendrite                       
PPP = 48   # Proximal per Pyramidal                      
BPP = 48   # Basal per Pyramidal                         
APP = 48   # Apical per Pyramidal                        
PinL2 = 32   # Pyramidal in L2                           
PinL4 = 32   # Pyramidal in L4                           
PinL6 = 32   # Pyramidal in L6                           
PinTh = 4    # Pyramidal in Thalmus                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
class Dendrite:                                          
  def __init__():                                        
    self.s = [  None    for i in range(SPD )]            
                                                         
                                                         
class Pyramidal:                                         
  def __init__():                                        
    self.State = 0                                       
    self.Proximal = [Dendrite() for i in range(PPP) ]    
    self.Basal = [Dendrite() for i in range(BPP) ]       
    self.Apical = [Dendrite() for i in range(APP) ]      
                                                         
                                                         
                                                         
                                                         
                                                         
class Minicolumn:                                        
  def __init():                                          
    self.L2 = [Pyramidal() for i in range(PinL2)]        
    self.L4 = [Pyramidal() for i in range(PinL4)]        
    self.L6 = [Pyramidal() for i in range(PinL6)]        
    self.Thalmus = [Pyramidal() for i in range(PinTh)]   
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
def initialize():                                        
                                                         
                                                         
                                                         
                                                         
  if len(sys.argv) > 1:                                  
                                                         
    print("  initializing")                              
    print(f"  {sys.argv[1]}")                            
                                                         
                                                         
                                                         
                                                         
  else:                                                  
    print("  parameter?")                                
                                                         
                                                         
                                                         
                                                         
def iterate():                                           
  print("  iterating")                                   
                                                         
                                                         
                                                         
                                                         
def summarize():                                         
  print("  summarizing")                                 
                                                         
                                                         
                                                         
                                                         
if __name__ == "__main__":                               
  print(" Brainiac")                                     
  initialize()                                           
  iterate()                                              
  summarize()                                            
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
