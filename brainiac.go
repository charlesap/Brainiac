// brainiac.go                                                 
package main                                             
import "fmt"                                                         
import "os"                                             
                                                         
const (                                                    
  PYRAMIDAL = 0                                            
  INHIBITOR = 1                                            
  SPD = 40  // Synapses per Dendrite                       
  DSZ = 40 * 4 // 32 bits per Synapse                      
  PPP = 32  // Proximal per Pyramidal                      
  BPP = 32  // Basal per Pyramidal                         
  APP = 32  // Apical per Pyramidal                        
  DPN = 32 + 32 + 32                                       
  PinL2 = 28  // Pyramidal in L2                           
  Acc2  = 28                                               
  PinL4 = 28  // Pyramidal in L4                           
  Acc4  = 28 + PinL2                                       
  PinL5 = 28  // Pyramidal in L5                           
  Acc5  = 28 + Acc4                                        
  PinL6 = 28  // Pyramidal in L6                           
  Acc6  = 28 + Acc5                                        
  PinTh = 4   // Pyramidal in Thalmus                      
  AccTh = 4  + Acc6                                        
  MCinC = 96  // Minicolumns in a Column                   
  CinP = 9    // Columns in a Patch                    
  NP = 100224                                              
)                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Potential struct { excited bool }                                                         
                                                         
                                                         
                                                         
type Synapse *Potential                                  
                                                         
                                                         
                                                         
type Dendrite [SPD]Synapse                                                                                  
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Pyramidal struct {                                                                                     
       State Potential                                                                                      
       Proximal [PPP]Dendrite                                                                               
       Basal [BPP]Dendrite                                                                                  
       Apical [APP]Dendrite                                                                                 
     }                                                                                                      
                                                         
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
type Minicolumn struct {                                                                                    
       L2 [PinL2]Pyramidal                                                       
       L4 [PinL4]Pyramidal                                                       
       L5 [PinL5]Pyramidal                                                       
       L6 [PinL6]Pyramidal                                                        
       Th [PinTh]Pyramidal                           
     }                                                   
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Column struct {                                                                                    
       MC [MCinC]Minicolumn                                                       
     }                                                      
                                                         
                                                        
                                                        
                                                        
                                                        
type Patch  struct {                                                                                    
       C [CinP]Column                                                           
     }                                                      
                                                         
                                                              
                              
                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func la2sa( a int )(c,mc,lv,lvo int){                                                                                 
   mci:=a % AccTh                                                                                                  
   mco:= a / AccTh;       mc = mco % MCinC                                                                       
   co:= a / (AccTh*MCinC); c= co % CinP                                                                          
   if       mci<PinL2{   lv=0;   lvo=mci                                                                          
   }else if mci<Acc4{    lv=1;   lvo=mci-PinL2                                                                    
   }else if mci<Acc5{    lv=2;   lvo=mci-Acc4                                                                     
   }else if mci<Acc6{    lv=3;   lvo=mci-Acc5                                                                     
   }else if mci<AccTh{   lv=4;   lvo=mci-Acc6                                                                     
   }else{                lv=-1;  lvo=-1  }                                                                        
   return c, mc, lv, lvo                                                                                          
}                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func initialize() *Patch {                                    
                                                      
  P:=new(Patch)                                                        
                                                       
  if len(os.Args) > 1 {
    fmt.Println("  initializing", os.Args[1])            
    pexfn:="b-"+os.Args[1]+
         "-9-96-4-28-28-28-28-0-0-0.pex"; 
    dndfn:="b-"+os.Args[1]+
         "-9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd";
    fpex, err1 := os.Open(pexfn)
    if err1 == nil {
      fdnd, err2 := os.Open(dndfn)
      if err2 == nil {
        dp:= SPD+PPP+BPP+APP                           
        fmt.Println("   dendrites:   ", dp*NP)         
        fmt.Println("   p cells  :     ", NP)                
        fmt.Println("   miniclmns:        ", CinP*MCinC)      
        fmt.Println("   loading...")                         
        for i:=0; i<NP;i++{                                              
      //    c,mc,lv,lvo:=la2sa(i)             
      //  fmt.Println("--",i,c,mc,lv,lvo)
                                               
                                                       
                                                       
                                                                
        }                                                                              
        fpex.Close()                                                                   
        fdnd.Close()                                                                   
      }else{                                                                           
        fmt.Println("  file",dndfn,"?",err2)                                           
      }                                                                                     
    }else{                                               
      fmt.Println("  file",pexfn,"?",err1)               
    }                                                    
  }else{                                                 
    fmt.Println("  parameter?")                          
  }                                                      
  return P                                               
}                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func iterate(P *Patch){                                       
                                                    
  fmt.Println("  iterating")                     
                                                         
}                                             
                                                         
func summarize(P *Patch){                                     
                                                    
  fmt.Println("  summarizing")                   
                                                         
}                                         
                                                         
func main(){                                                    
  fmt.Println(" Brainiac")                       
                                                         
  P:=initialize()                                            
  iterate(P)                                           
  summarize(P)                                             
                                                         
                                                         
                                                         
                                                         
                                                         
}                                            
                                                         
                                                         
                                                         
                                                         
