// Brainiac.java                                         
import java.io.*;                                        
public class Brainiac {                                  
                                                         
                                                         
                                                         
  final static int SPD = 40; // Synapses per Dendrite    
  final static int PPP = 48; // Proximal per Pyramidal   
  final static int BPP = 48; // Basal per Pyramidal      
  final static int APP = 48; // Apical per Pyramidal     
  final static int PinL2 = 32; // Pyramidal in L2        
  final static int PinL4 = 32; // Pyramidal in L4        
  final static int Acc4  = 32 + PinL2;                   
  final static int PinL5 = 32; // Pyramidal in L5        
  final static int Acc5  = 32 + Acc4;                    
  final static int PinL6 = 32; // Pyramidal in L6        
  final static int Acc6  = 32 + Acc5;                    
  final static int PinTh = 4;  // Pyramidal in Thalmus   
  final static int AccTh = 4  + Acc6;                    
  final static int MCinC = 128; // Minicolumns per Column
  final static int CinP = 9  ; // Columns in a Patch     
  final static int NP = 152064;                          
                                                         
                                                         
                                                         
  public static class Potential{                         
    Boolean excited;                                     
  }                                                      
                                                         
  public static class Synapse{                           
    int Potential;                                       
  }                                                      
                                                         
  public static class Dendrite{                          
    Synapse s;                                           
                                                         
    public Dendrite(){                                   
                                                         
    }                                                    
  }                                                      
  public static class Pyramidal{                         
    int State;                                           
    Dendrite[] Proximal;                                 
    Dendrite[] Basal;                                    
    Dendrite[] Apical;                                   
                                                         
    public Pyramidal(){                                  
           State = 0;                                    
           Proximal = new Dendrite[PPP];                 
           Basal = new Dendrite[BPP];                    
           Apical = new Dendrite[APP];                   
    }                                                    
  }                                                      
                                                         
  public static class Minicolumn{                        
    Pyramidal[] L2;                                      
    Pyramidal[] L4;                                      
    Pyramidal[] L5;                                      
    Pyramidal[] L6;                                      
    Pyramidal[] Thalmus;                                 
                                                         
    public Minicolumn(){                                 
           L2 = new Pyramidal[PinL2];                    
           L4 = new Pyramidal[PinL4];                    
           L5 = new Pyramidal[PinL5];                    
           L6 = new Pyramidal[PinL6];                    
           Thalmus = new Pyramidal[PinTh];               
    }                                                    
  }                                                      
                                                         
  public static class Column{                            
    Minicolumn[] MC;                                     
                                                         
    public Column(){                                     
           MC = new Minicolumn[MCinC];                   
    }                                                    
  }                                                      
                                                         
  public static class Patch{                             
    Column[] C;                                          
                                                         
    public Patch(){                                      
           C = new Column[CinP];                         
    }                                                    
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static int[] la2sa( int a){                     
                                                         
    int r[] = new int[4]; //c,mc,lv,lvo                  
                             int mci = a  % AccTh;       
    int mco = a  / AccTh;r[1] = mco % MCinC;             
    int co = a / (AccTh*MCinC);r[0]=co % CinP;           
    if      (mci<PinL2) {r[2]=0;  r[3]=mci;              
    }else if(mci<Acc4)  {r[2]=1;  r[3]=mci-PinL2;        
    }else if(mci<Acc5)  {r[2]=2;  r[3]=mci-Acc4;         
    }else if(mci<Acc6)  {r[2]=3;  r[3]=mci-Acc5;         
    }else if(mci<AccTh) {r[2]=4;  r[3]=mci-Acc6;         
    }else               {r[2]=-1; r[3]=-1;               
    }                                                    
                                                         
                                                         
                                                         
                                                         
                                                         
    return r;                                            
  }                                                      
                                                         
  public static Patch initialize(String[] args){         
    int dp,c,mc,lv,lvo; int[] a;                         
                                                         
    Patch P;                                             
                                                         
    P = null;                                            
    if (args.length > 0) {                               
      System.out.println("  initializing "+args[0]);     
      String pexfn="b-"+args[0]+                         
         "-9-128-4-32-32-32-32-0-0-0.pex";               
      String dndfn="b-"+args[0]+                         
         "-9-128-4-32-32-32-32-48-48-48-40-0-0-0.dnd";   
      try (                                              
        InputStream fpex = new FileInputStream(pexfn);   
        InputStream fdnd = new FileInputStream(dndfn);   
      ) {                                                
        dp= SPD+PPP+BPP+APP;                             
                                                         
        System.out.println("   dendrites:    "+dp*NP);   
        System.out.println("   p cells  :      "+NP);    
        System.out.println("   miniclmns:        "+      
                           CinP*MCinC);                  
        P = new Patch();                                 
        for(int i=0;i<NP;i++){                           
          a = la2sa(i);c=a[0];mc=a[1];lv=a[2];lvo=a[3];  
//System.out.println("--"+i+" "+c+" "+mc+" "+lv+" "+lvo);
                                                         
        }                                                
      } catch (IOException ex) {                         
        ex.printStackTrace();                            
      }                                                  
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
                                                         
                                                         
                                                         
                                                         
