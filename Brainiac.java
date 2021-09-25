// Brainiac.java                                         
public class Brainiac {                                  
//import sys                                             
                                                         
                                                         
                                                         
  final int SPD = 40; // Synapses per Dendrite           
  final int PPP = 48; // Proximal per Pyramidal          
  final int BPP = 48; // Basal per Pyramidal             
  final int APP = 48; // Apical per Pyramidal            
  final int PinL2 = 32; // Pyramidal in L2               
  final int PinL4 = 32; // Pyramidal in L4               
  final int PinL6 = 32; // Pyramidal in L6               
  final int PinTh = 4;  // Pyramidal in Thalmus          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public class Dendrite{                                 
  //public Dendrite{                                     
  //  self.s = [  None    for i in range(SPD )]          
  }                                                      
                                                         
  public class Pyramidal{                                
    int State;                                           
                                                         
    public Pyramidal(){                                  
           State = 0;                                    
  //  self.Proximal = [Dendrite() for i in range(PPP) ]  
  //  self.Basal = [Dendrite() for i in range(BPP) ]     
  //  self.Apical = [Dendrite() for i in range(APP) ]    
    }                                                    
  }                                                      
                                                         
  public class Minicolumn{                               
  //def __init():                                        
  //  self.L2 = [Pyramidal() for i in range(PinL2)]      
  //  self.L4 = [Pyramidal() for i in range(PinL4)]      
  //  self.L6 = [Pyramidal() for i in range(PinL6)]      
  //  self.Thalmus = [Pyramidal() for i in range(PinTh)] 
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  public static void initialize(String[] args){          
                                                         
                                                         
                                                         
                                                         
    if (args.length > 0) {                               
                                                         
      System.out.println("  initializing");              
      System.out.println(args[0]);                       
                                                         
                                                         
                                                         
                                                         
    }else{                                               
      System.out.println("  parameter?");                
    }                                                    
  }                                                      
                                                         
                                                         
  public static void iterate(){                          
    System.out.println("  iterating");                   
  }                                                      
                                                         
                                                         
                                                         
  public static void  summarize(){                       
    System.out.println("  summarizing");                 
                                                         
  }                                                      
                                                         
                                                         
  public static void main (String[] args)    {           
    System.out.println(" Brainiac");                     
    initialize(args);                                    
    iterate();                                           
    summarize();                                         
  }                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
}                                                        
                                                         
                                                         
                                                         
                                                         
