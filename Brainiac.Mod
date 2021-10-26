(* Brainiac.Mod *)                                       
MODULE Brainiac;                                         
                                                         
IMPORT Args := extArgs, Err := extErr, Out, Files;       
                                                         
CONST                                                    
  PYRAMIDAL = 0;                                         
  INHIBITOR = 1;                                         
  SPD = 40; (* Synapses per Dendrite *)                  
  DSZ = 40 * 4; (* 32 bits per Synapse *)                
  PPP = 32; (* Proximal per Pyramidal *)                 
  BPP = 32; (* Basal per Pyramidal *)                    
  APP = 32; (* Apical per Pyramidal *)                   
  DPN = 32 + 32 + 32;                                    
  PinL2 = 28; (* Pyramidal in L2 *)                      
  Acc2  = 28;                                            
  PinL4 = 28; (* Pyramidal in L4 *)                      
  Acc4  = 28 + PinL2;                                    
  PinL5 = 28; (* Pyramidal in L5 *)                      
  Acc5  = 28 + Acc4;                                     
  PinL6 = 28; (* Pyramidal in L6 *)                      
  Acc6  = 28 + Acc5;                                     
  PinTh = 4;  (* Pyramidal in Thalmus *)                 
  AccTh = 4  + Acc6;                                     
  MCinC = 96 ;(* Minicolumns in a Column *)              
  CinP = 9 ; (* Columns in a Patch *)                    
  NP = 100224;                                           
                                                         
                                                         
TYPE                                                     
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  Potential = INTEGER;                                   
                                                         
                                                         
                                                         
  Synapse = INTEGER;                                     
                                                         
                                                         
                                                         
  Dendrite = ARRAY SPD OF Synapse;                       
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  Neuron    = RECORD                                     
             State: INTEGER;                             
             Kind: INTEGER;                              
             De:    ARRAY DPN OF Dendrite                
                                                         
           END;                                          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  Minicolumn = RECORD                                    
                  N: ARRAY AccTh OF Neuron               
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
                                                         
PROCEDURE NL; BEGIN Out.Ln END NL;                       
PROCEDURE OI(I,X:INTEGER); BEGIN Out.Int(I,X) END OI;    
PROCEDURE OS(S:ARRAY OF CHAR);BEGIN Out.String(S) END OS;
PROCEDURE SAP(VAR t: ARRAY OF CHAR;s: ARRAY OF CHAR);    
VAR x,y:INTEGER; BEGIN x:=0; WHILE t[x]#0X DO INC(x) END;
  y:=0;WHILE s[y]#0X DO t[x]:=s[y];INC(x);INC(y) END;    
  t[x]:=0X;                                              
END SAP;                                                 
                                                         
PROCEDURE la2sa(a:INTEGER; VAR c,mc,ni,lv,lvo: INTEGER); 
                                                         
VAR mco,co: INTEGER;                                     
BEGIN  ni := a MOD AccTh; mco := a DIV AccTh;            
 mc:=mco MOD MCinC;co:=a DIV(AccTh*MCinC);c:=co MOD CinP;
  IF     ni<PinL2 THEN lv:=0;  lvo:= ni                  
  ELSIF  ni<Acc4  THEN lv:=1;  lvo:= ni-PinL2            
  ELSIF  ni<Acc5  THEN lv:=2;  lvo:= ni-Acc4             
  ELSIF  ni<Acc6  THEN lv:=3;  lvo:= ni-Acc5             
  ELSIF  ni<AccTh THEN lv:=4;  lvo:= ni-Acc6             
  ELSE                 lv:=-1; lvo:=-1                   
  END                                                    
END la2sa;                                               
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
PROCEDURE initialize(VAR p: PPatch);                     
CONST td ="-9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd";   
      tp ="-9-96-4-28-28-28-28-0-0-0.pex";               
VAR i,res,dp,c,mc,ni,lv,lvo:INTEGER;fdnd,fpex:Files.File;
      arg,pexfn,dndfn:ARRAY 256 OF CHAR;                 
      n: POINTER TO Neuron;rdnd,rpex:Files.Rider;        
BEGIN                                                    
  IF Args.count > 0 THEN Args.Get(0, arg, res);          
    IF res = 0 THEN                                      
      OS("  initializing "); OS(arg); NL;                
      pexfn:="b-";SAP(pexfn,arg);SAP(pexfn,tp);          
      dndfn:="b-";SAP(dndfn,arg);SAP(dndfn,td);          
      fpex:=Files.Old(pexfn);                            
      IF fpex # NIL  THEN                                
        fdnd:=Files.Old(dndfn);                          
        IF fdnd # NIL  THEN                              
          Files.Set(rpex,fpex,0);                        
          Files.Set(rdnd,fdnd,0);                        
          dp:=SPD+PPP+BPP+APP;                           
          OS("   dendrites:"); OI(dp*NP,12); NL;         
          OS("   p cells  :"); OI(NP,12); NL;            
          OS("   miniclmns:"); OI(CinP*MCinC,12); NL;    
          OS("   loading...");                    NL;    
          NEW(p);                                        
          i:=0; WHILE (i<NP) DO                          
            la2sa(i,c,mc,ni,lv,lvo);                     
        (*  n:=p.C[c].MC[mc].N[ni]; *)                   
            Files.ReadInt(rpex,p.C[c].MC[mc].N[ni].Kind);
          Files.ReadInt(rpex,p.C[c].MC[mc].N[ni].State); 
                                                         
                                                         
    (*      OS("--");OI(i,8);OI(c,8);OI(mc,8);           
            OI(lv,8);OI(lvo,8);NL;      *)               
            INC(i)                                       
          END                                            
        ELSE  OS("  file "); OS(dndfn); OS("?"); NL;     
        END                                              
      ELSE  OS("  file "); OS(pexfn); OS("?"); NL;       
      END                                                
    ELSE  OS("  config?"); NL;                           
    END                                                  
  ELSE  OS("  parameter?"); NL;                          
  END                                                    
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
                                                         
                                                         
                                                         
                                                         
