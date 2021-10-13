// Brainiac.java                                         
public class Brainiac {                                  
//import sys                                             
                                                         
                                                         
                                                         
  final static int SPD = 40; // Synapses per Dendrite    
  final static int PPP = 48; // Proximal per Pyramidal   
  final static int BPP = 48; // Basal per Pyramidal      
  final static int APP = 48; // Apical per Pyramidal     
  final static int PinL2 = 32; // Pyramidal in L2        
  final static int PinL4 = 32; // Pyramidal in L4        
  final static int PinL5 = 32; // Pyramidal in L5        
  final static int PinL6 = 32; // Pyramidal in L6        
  final static int PinTh = 4;  // Pyramidal in Thalmus   
  final static int MCinC = 128; // Minicolumns per Column
  final static int CinP = 9  ; // Columns in a Patch     
                                                         
                                                         
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
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static Patch initialize(String[] args){         
    int dp;                                              
    int np;                                              
    Patch P;                                             
                                                         
    P = null;                                            
    if (args.length > 0) {                               
      System.out.println("  initializing "+args[0]);     
                                                         
      dp= SPD+PPP+BPP+APP;                               
      np=(PinL2+PinL4+PinL5+PinL6+PinTh)*MCinC*CinP;     
      System.out.println("   dendrites:    "+dp*np);     
      System.out.println("   p cells  :      "+np);      
  System.out.println("   miniclmns:        "+CinP*MCinC);
      P = new Patch();                                   
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
                                                         
                                                         
                                                         
                                                         
