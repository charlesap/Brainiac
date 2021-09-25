(* Brainiac.Mod *)                                       
MODULE Brainiac;                                         
                                                         
IMPORT Args := extArgs, Err := extErr, Out;              
                                                         
CONST                                                    
  SPD = 40; (* Synapses per Dendrite *)                  
  PPP = 48; (* Proximal per Pyramidal *)                 
  BPP = 48; (* Basal per Pyramidal *)                    
  APP = 48; (* Apical per Pyramidal *)                   
  PinL2 = 32; (* Pyramidal in L2 *)                      
  PinL4 = 32; (* Pyramidal in L4 *)                      
  PinL6 = 32; (* Pyramidal in L6 *)                      
  PinTh = 4;  (* Pyramidal in Thalmus *)                 
                                                         
TYPE                                                     
  Potential = RECORD Excited: BOOLEAN END;               
                                                         
  Synapse = INTEGER; (* PTR to Potential w/o GC *)       
                                                         
  Dendrite = ARRAY SPD OF Synapse;                       
                                                         
                                                         
                                                         
                                                         
  Pyramidal = RECORD                                     
             State: Potential;                           
             Proximal:  ARRAY PPP OF Dendrite;           
             Basal: ARRAY BPP OF Dendrite;               
             Apical: ARRAY APP OF Dendrite               
           END;                                          
                                                         
                                                         
                                                         
                                                         
                                                         
  Minicolumn = RECORD                                    
                 L2: ARRAY PinL2 OF Pyramidal;           
                 L4: ARRAY PinL4 OF Pyramidal;           
                 L6: ARRAY PinL6 OF Pyramidal;           
                 Thalmus: ARRAY PinTh OF Pyramidal       
               END;                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
PROCEDURE initialize;                                    
VAR                                                      
  i,res:INTEGER;                                         
  arg:ARRAY 256 OF CHAR;                                 
BEGIN                                                    
  IF Args.count > 0 THEN                                 
    Args.Get(0, arg, res);                               
    IF res = 0 THEN                                      
      Out.String("  initializing"); Out.Ln;              
      Out.String("  "); Out.String(arg); Out.Ln;         
    ELSE                                                 
      Out.String("  config?"); Out.Ln;                   
    END                                                  
  ELSE                                                   
    Out.String("  parameter?"); Out.Ln;                  
  END                                                    
END initialize;                                          
                                                         
                                                         
PROCEDURE iterate;                                       
BEGIN                                                    
  Out.String("  iterating"); Out.Ln;                     
                                                         
END iterate;                                             
                                                         
PROCEDURE summarize;                                     
BEGIN                                                    
  Out.String("  summarizing"); Out.Ln;                   
                                                         
END summarize;                                           
                                                         
BEGIN                                                    
  Out.String(" Brainiac"); Out.Ln;                       
                                                         
  initialize;                                            
  iterate;                                               
  summarize;                                             
                                                         
                                                         
                                                         
                                                         
                                                         
END Brainiac.                                            
                                                         
                                                         
                                                         
                                                         
