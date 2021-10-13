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
  PinL5 = 32  // Pyramidal in L5                           
  PinL6 = 32  // Pyramidal in L6                           
  PinTh = 4   // Pyramidal in Thalmus                      
  MCinC = 128 // Minicolumns in a Column                   
  CinP = 9    // Columns in a Patch                    
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
       Thalmus [PinTh]Pyramidal                           
     }                                                   
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Column struct {                                                                                    
       MC [MCinC]Minicolumn                                                       
     }                                                      
                                                         
                                                        
                                                        
                                                        
                                                        
type Patch  struct {                                                                                    
       C [CinP]Column                                                           
     }                                                      
                                                         
                                                              
                              
                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func initialize() *Patch {                                    
                                                      
  P:=new(Patch)                                                        
                                                       
  if len(os.Args) > 1 {
    fmt.Println("  initializing", os.Args[1])            
    dp:= SPD+PPP+BPP+APP                                      
    np:=(PinL2+PinL4+PinL5+PinL6+PinTh)*MCinC*CinP                                                                                      
    fmt.Println("   dendrites:   ", dp*np)                                                                       
    fmt.Println("   p cells  :     ", np)
    fmt.Println("   miniclmns:       ", CinP*MCinC)        
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
                                                         
                                                         
                                                         
                                                         
