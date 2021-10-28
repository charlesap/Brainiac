// brainiac.go                                                 
package main                                             
import "fmt"                                                         
import "os"                                             
import "bufio"                                                         
import "time"                                              
                                                         
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
                                                         
                                                         
                                                         
type Synapse int32                                       
                                                         
                                                         
                                                         
type Dendrite   struct {                                                                                    
        S [SPD]Synapse                                   
     }                                                   
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Neuron    struct {                                                                                     
       State int16                                                                                          
       Kind  int16                                                                                          
       De    [DPN]Dendrite                                                                                  
                                                                                                            
     }                                                                                                      
                                                         
                                                         
                                                         
                                                         
                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Minicolumn struct {                                                                                    
        N [AccTh]Neuron                                                          
                                                                                 
                                                                                  
                                                                                   
                                                     
     }                                                   
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
type Column struct {                                                                                    
       MC [MCinC]Minicolumn                                                       
     }                                                      
                                                         
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
type Patch  struct {                                                                                    
       C [CinP]Column                                                           
     }                                                      
                                                         
                                                              
                              
                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func la2sa( a int )(c,mc,ni,lv,lvo int){                                                                                 
    ni =a % AccTh                                                                                                  
   mco:= a / AccTh;       mc = mco % MCinC                                                                       
   co:= a / (AccTh*MCinC); c= co % CinP                                                                          
   if        ni<PinL2{   lv=0;   lvo= ni                                                                          
   }else if  ni<Acc4{    lv=1;   lvo= ni-PinL2                                                                    
   }else if  ni<Acc5{    lv=2;   lvo= ni-Acc4                                                                     
   }else if  ni<Acc6{    lv=3;   lvo= ni-Acc5                                                                     
   }else if  ni<AccTh{   lv=4;   lvo= ni-Acc6                                                                     
   }else{                lv=-1;  lvo=-1  }                                                                        
   return c, mc, ni, lv, lvo                                                                                          
}                                                        
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
func initialize() *Patch {                                    
                                                      
  P:=new(Patch)                                                        
  tvs:=time.Now().UnixMilli()                           
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
        d    := make([]byte, DPN*SPD*4)                                  
        drdr := bufio.NewReader(fdnd)               
        fpex.Close()                         
        b,_ :=os.ReadFile(pexfn)               
        for i:=0; i<NP;i++{                            
            c,mc,ni,_,_:=la2sa(i)                      
      //  fmt.Println("--",i,c,mc,lv,lvo)    
          P.C[c].MC[mc].N[ni].Kind=                                                       
              (int16)(b[i*4+0]+(b[i*4+1]<<8))
          P.C[c].MC[mc].N[ni].State=                                       
              (int16)(b[i*4+2]+(b[i*4+3]<<8))                                          
          _,_   = drdr.Read(d    )                                                     
          for j:=0; j<DPN; j++{                                                                                  
            for k:=0; k<SPD; k++{                                                     
              P.C[c].MC[mc].N[ni].De[j].S[k]=              
              (Synapse)(d[((j*SPD)+k)*4+0]+(d[((j*SPD)+k)*4+1]<<8)+              
              (d[((j*SPD)+k)*4+2]<<16)+(d[((j*SPD)+k)*4+3]<<24))             
            }                                            
          }                                              
        }                                                
        fdnd.Close()                                     
      }else{                                             
        fmt.Println("  file",dndfn,"?",err2)             
      }                                                  
    }else{                                               
      fmt.Println("  file",pexfn,"?",err1)               
    }                                                    
    fmt.Println("  MSEC INIT:",time.Now().UnixMilli()-tvs)                       
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
                                                         
                                                         
                                                         
                                                         
