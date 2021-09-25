// brainiac.go                                                 
package main                                             
import "fmt"                                                         
import "os"                                             
                                                         
const (                                                    
  SPD = 40  // Synapses per Dendrite                       
  PPP = 48  // Proximal per Pyramidal                      
  BPP = 48  // Basal per Pyramidal                         
  APP = 48  // Apical per Pyramidal                        
  PinL2 = 32  // Pyramidal in L2                           
  PinL4 = 32  // Pyramidal in L4                           
  PinL6 = 32  // Pyramidal in L6                           
  PinTh = 4   // Pyramidal in Thalmus                      
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
       L6 [PinL6]Pyramidal                                                       
       Thalmus [PinTh]Pyramidal                                                   
     }                                                    
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func initialize(){                                    
                                                      
                                                          
                                                       
  if len(os.Args) > 1 {
                                                         
    fmt.Println("  initializing")                 
    fmt.Println("  ",os.Args[1])                                                       
                                                           
  }else{                               
    fmt.Println("  parameter?")                          
  }                                                      
}                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func iterate(){                                       
                                                    
  fmt.Println("  iterating")                     
                                                         
}                                             
                                                         
func summarize(){                                     
                                                    
  fmt.Println("  summarizing")                   
                                                         
}                                         
                                                         
func main(){                                                    
  fmt.Println(" Brainiac")                       
                                                         
  initialize()                                            
  iterate()                                           
  summarize()                                             
                                                         
                                                         
                                                         
                                                         
                                                         
}                                            
                                                         
                                                         
                                                         
                                                         
