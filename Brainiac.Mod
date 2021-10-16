(* Brainiac.Mod *)                                       
MODULE Brainiac;                                         
                                                         
IMPORT Args := extArgs, Err := extErr, Out, Files;       
                                                         
CONST                                                    
  SPD = 40; (* Synapses per Dendrite *)                  
  PPP = 48; (* Proximal per Pyramidal *)                 
  BPP = 48; (* Basal per Pyramidal *)                    
  APP = 48; (* Apical per Pyramidal *)                   
  PinL2 = 32; (* Pyramidal in L2 *)                      
  PinL4 = 32; (* Pyramidal in L4 *)                      
  Acc4  = 32 + PinL2;                                    
  PinL5 = 32; (* Pyramidal in L5 *)                      
  Acc5  = 32 + Acc4;                                     
  PinL6 = 32; (* Pyramidal in L6 *)                      
  Acc6  = 32 + Acc5;                                     
  PinTh = 4;  (* Pyramidal in Thalmus *)                 
  AccTh = 4  + Acc6;                                     
  MCinC = 128;(* Minicolumns in a Column *)              
  CinP = 9 ; (* Columns in a Patch *)                    
  NP = 152064;                                           
                                                         
                                                         
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
                                                         
PROCEDURE NL; BEGIN Out.Ln END NL;                       
PROCEDURE OI(I,X:INTEGER); BEGIN Out.Int(I,X) END OI;    
PROCEDURE OS(S:ARRAY OF CHAR);BEGIN Out.String(S) END OS;
PROCEDURE SAP(VAR t: ARRAY OF CHAR;s: ARRAY OF CHAR);    
VAR x,y:INTEGER; BEGIN x:=0; WHILE t[x]#0X DO INC(x) END;
  y:=0;WHILE s[y]#0X DO t[x]:=s[y];INC(x);INC(y) END;    
  t[x]:=0X;                                              
END SAP;                                                 
                                                         
PROCEDURE la2sa(a:INTEGER; VAR c,mc,lv,lvo: INTEGER);    
                                                         
VAR mci,mco,co: INTEGER;                                 
BEGIN mci := a MOD AccTh; mco := a DIV AccTh;            
 mc:=mco MOD MCinC;co:=a DIV(AccTh*MCinC);c:=co MOD CinP;
  IF    mci<PinL2 THEN lv:=0;  lvo:=mci                  
  ELSIF mci<Acc4  THEN lv:=1;  lvo:=mci-PinL2            
  ELSIF mci<Acc5  THEN lv:=2;  lvo:=mci-Acc4             
  ELSIF mci<Acc6  THEN lv:=3;  lvo:=mci-Acc5             
  ELSIF mci<AccTh THEN lv:=4;  lvo:=mci-Acc6             
  ELSE                 lv:=-1; lvo:=-1                   
  END                                                    
END la2sa;                                               
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
PROCEDURE initialize(VAR p: PPatch);                     
CONST td ="-9-128-4-32-32-32-32-48-48-48-40-0-0-0.dnd";  
      tp ="-9-128-4-32-32-32-32-0-0-0.pex";              
VAR i,res,dp,c,mc,lv,lvo: INTEGER; fdnd,fpex: Files.File;
      arg,pexfn,dndfn:ARRAY 256 OF CHAR;                 
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
          dp:=SPD+PPP+BPP+APP;                           
                                                         
          OS("   dendrites:"); OI(dp*NP,12); NL;         
          OS("   p cells  :"); OI(NP,12); NL;            
          OS("   miniclmns:"); OI(CinP*MCinC,12); NL;    
          NEW(p);                                        
          i:=0; WHILE (i<NP) DO                          
            la2sa(i,c,mc,lv,lvo);                        
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
                                                         
                                                         
                                                         
                                                         
