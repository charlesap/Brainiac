// Brainiac.java                                         
import java.io.*;                                        
import java.time.*;                                      
public class Brainiac {                                  
                                                         
                                                         
                                                         
                                                         
                                                         
  final static int PYRAMIDAL = 0;                        
  final static int INHIBITOR = 1;                        
  final static int SPD = 40; // Synapses per Dendrite    
  final static int DSZ = 40 * 4; // 32 bits per Synapse  
  final static int PPP = 32; // Proximal per Pyramidal   
  final static int BPP = 32; // Basal per Pyramidal      
  final static int APP = 32; // Apical per Pyramidal     
  final static int DPN = 32 + 32 + 32;                   
  final static int PinL2 = 28; // Pyramidal in L2        
  final static int Acc2  = 28;                           
  final static int PinL4 = 28; // Pyramidal in L4        
  final static int Acc4  = 28 + PinL2;                   
  final static int PinL5 = 28; // Pyramidal in L5        
  final static int Acc5  = 28 + Acc4;                    
  final static int PinL6 = 28; // Pyramidal in L6        
  final static int Acc6  = 28 + Acc5;                    
  final static int PinTh = 4;  // Pyramidal in Thalmus   
  final static int AccTh = 4  + Acc6;                    
  final static int MCinC = 96 ; // Minicolumns per Column
  final static int CinP = 9  ; // Columns in a Patch     
  final static int NP = 100224;                          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static class Dendrite{                          
    int[]   S;                                           
                                                         
    public Dendrite(InputStream fdnd){                   
           S = new int[SPD];                             
      byte[] b = new byte[SPD*4];                        
      try {                                              
        fdnd.read(b);                                    
        for(int i=0;i<SPD;i++){                          
          S[i]=b[i*4]+(b[i*4+1]<<8)+                     
              (b[i*4+2]<<16)+(b[i*4+3]<<24);             
        }                                                
      } catch (IOException ex){                          
        ex.printStackTrace();                            
      }                                                  
    }                                                    
  }                                                      
                                                         
  public static class   Neuron{                          
    int State;                                           
    int Kind;                                            
    Dendrite[] De;                                       
                                                         
                                                         
    public Neuron(InputStream fpex, InputStream fdnd){   
      byte[] b      = new byte[4];                       
      try                  {                             
        fpex.read(b);                                    
        De    = new Dendrite[DPN];                       
        State = b[0]+(b[1]<<8);                          
        Kind = b[2]+(b[3]<<16);                          
        for(int i=0;i<DPN;i++){                          
          De[i] = new Dendrite(fdnd);                    
        }                                                
      } catch (IOException ex) {                         
        ex.printStackTrace();                            
      }                                                  
    }                                                    
  }                                                      
                                                         
  public static class Minicolumn{                        
    Neuron[] N;                                          
                                                         
   public Minicolumn(InputStream fpex, InputStream fdnd){
            N = new    Neuron[AccTh];                    
      for(int i=0;i<AccTh;i++){                          
        N[i] = new Neuron(fpex,fdnd);                    
      }                                                  
    }                                                    
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static class Column{                            
    Minicolumn[] MC;                                     
                                                         
    public Column(InputStream fpex, InputStream fdnd){   
       MC = new Minicolumn[MCinC];                       
       for(int i=0;i<MCinC;i++){                         
         MC[i] = new Minicolumn(fpex,fdnd);              
       }                                                 
    }                                                    
  }                                                      
                                                         
  public static class Patch{                             
    Column[] C;                                          
                                                         
    public Patch(InputStream fpex, InputStream fdnd){    
      C = new Column[CinP];                              
      for(int i=0;i<CinP;i++){                           
        C[i] = new Column(fpex,fdnd);                    
      }                                                  
    }                                                    
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static int[] la2sa( int a){                     
                                                         
    int r[] = new int[5]; //c,mc,ni,lv,lvo               
                             int mci = a  % AccTh;       
    int mco = a  / AccTh;r[1] = mco % MCinC;             
    int co = a / (AccTh*MCinC);r[0]=co % CinP;           
    if      (mci<PinL2) {r[3]=0;  r[4]=mci;              
    }else if(mci<Acc4)  {r[3]=1;  r[4]=mci-PinL2;        
    }else if(mci<Acc5)  {r[3]=2;  r[4]=mci-Acc4;         
    }else if(mci<Acc6)  {r[3]=3;  r[4]=mci-Acc5;         
    }else if(mci<AccTh) {r[3]=4;  r[4]=mci-Acc6;         
    }else               {r[3]=-1; r[4]=-1;               
    }                                                    
    r[2]=mci;                                            
                                                         
                                                         
                                                         
                                                         
    return r;                                            
  }                                                      
                                                         
  public static Patch initialize(String[] args){         
    int dp,c,mc,ni,lv,lvo; int[] a;                      
                                                         
    Patch P;                                             
    Instant tvs = Instant.now();                         
    P = null;                                            
    if (args.length > 0) {                               
      System.out.println("  initializing "+args[0]);     
      String pexfn="b-"+args[0]+                         
         "-9-96-4-28-28-28-28-0-0-0.pex";                
      String dndfn="b-"+args[0]+                         
         "-9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd";    
      try (                                              
        InputStream fpex = new FileInputStream(pexfn);   
        InputStream fdnd = new FileInputStream(dndfn);   
      ) {                                                
        dp= SPD+PPP+BPP+APP;                             
        System.out.println("   dendrites:    "+dp*NP);   
        System.out.println("   p cells  :      "+NP);    
        System.out.println("   miniclmns:         "+     
                           CinP*MCinC);                  
        System.out.println("   loading...");             
        P = new Patch(fpex,fdnd);                        
        byte[] b      = new byte[NP*4];                  
        fpex.read(b);                                    
        for(int i=0;i<NP;i++){                           
    a = la2sa(i);c=a[0];mc=a[1];ni=a[2];lv=a[3];lvo=a[4];
//System.out.println("--"+i+" "+c+" "+mc+" "+lv+" "+lvo);
         if (P.C[c] != null){                            
         P.C[c].MC[mc].N[ni].Kind=b[i*4+0]+(b[i*4+1]<<8);
         }                                               
                                                         
        }                                                
      } catch (IOException ex) {                         
        ex.printStackTrace();                            
      }                                                  
      Instant tve = Instant.now();                       
      long t = Duration.between(tvs, tve).toMillis();    
      System.out.println("  MSEC INIT:"+ t);             
    }else{                                               
      System.out.println("  parameter?");                
    }                                                    
    return P;                                            
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static void iterate(Patch P){                   
    System.out.println("  iterating");                   
  }                                                      
                                                         
                                                         
                                                         
  public static void  summarize(Patch P){                
    System.out.println("  summarizing");                 
                                                         
  }                                                      
                                                         
                                                         
  public static void main (String[] args)    {           
    Patch P;                                             
    System.out.println(" Brainiac");                     
    P=initialize(args);                                  
    iterate(P);                                          
    summarize(P);                                        
  }                                                      
                                                         
                                                         
                                                         
                                                         
}                                                        
                                                         
                                                         
                                                         
                                                         
