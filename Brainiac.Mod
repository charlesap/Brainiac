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
  PinL5 = 32; (* Pyramidal in L5 *)                      
  PinL6 = 32; (* Pyramidal in L6 *)                      
  PinTh = 4;  (* Pyramidal in Thalmus *)                 
  MCinC = 128;(* Minicolumns in a Column *)              
  CinP = 9 ; (* Columns in a Patch *)                    
                                                         
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
                 L5: ARRAY PinL5 OF Pyramidal;           
                 L6: ARRAY PinL6 OF Pyramidal;           
                 Thalmus: ARRAY PinTh OF Pyramidal       
               END;                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  Column = RECORD                                        
                 MC: ARRAY MCinC OF Minicolumn           
               END;                                      
                                                         
                                                         
                                                         
                                                         
                                                         
  Patch = RECORD                                         
                  C: ARRAY CinP OF Column                
               END;                                      
  PPatch = POINTER TO Patch;                             
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
VAR                                                      
  P: PPatch;                                             
                                                         
PROCEDURE initialize(VAR p: PPatch);                     
VAR                                                      
  i,res,dp,np:INTEGER;                                   
  arg:ARRAY 256 OF CHAR;                                 
BEGIN                                                    
  IF Args.count > 0 THEN                                 
    Args.Get(0, arg, res);                               
    IF res = 0 THEN                                      
      Out.String("  initializing ");                     
      Out.String(arg); Out.Ln;                           
      dp:=SPD+PPP+BPP+APP;                               
      np:=(PinL2+PinL4+PinL5+PinL6+PinTh)*MCinC*CinP;    
      Out.String("   dendrites:");                       
      Out.Int(dp*np,12); Out.Ln;                         
      Out.String("   p cells  :");                       
      Out.Int(np,12); Out.Ln;                            
      Out.String("   miniclmns:");                       
      Out.Int(CinP*MCinC,12); Out.Ln;                    
      NEW(p)                                             
    ELSE                                                 
      Out.String("  config?"); Out.Ln;                   
    END                                                  
  ELSE                                                   
    Out.String("  parameter?"); Out.Ln;                  
  END;                                                   
                                                         
END initialize;                                          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
PROCEDURE iterate(VAR p: PPatch);                        
                                                         
BEGIN                                                    
  Out.String("  iterating"); Out.Ln;                     
END iterate;                                             
                                                         
PROCEDURE summarize(VAR p: PPatch);                      
BEGIN                                                    
  Out.String("  summarizing"); Out.Ln;                   
                                                         
END summarize;                                           
                                                         
BEGIN                                                    
  Out.String(" Brainiac"); Out.Ln;                       
                                                         
  initialize(P);                                         
  iterate(P);                                            
  summarize(P);                                          
                                                         
                                                         
                                                         
                                                         
                                                         
END Brainiac.                                            
                                                         
                                                         
                                                         
                                                         
