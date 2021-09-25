/* brainiac.c */                                           
                                                           
#include <stdbool.h>                                       
#include <stdio.h>                                         
                                                           
                                                           
#define SPD   40  // Synapses per Dendrite                 
#define PPP   48  // Proximal per Pyramidal                
#define BPP   48  // Basal per Pyramidal                   
#define APP   48  // Apical per Pyramidal                  
#define PinL2   32  // Pyramidal in L2                     
#define PinL4   32  // Pyramidal in L4                     
#define PinL6   32  // Pyramidal in L6                     
#define PinTh   4   // Pyramidal in Thalmus                
                                                           
                                                           
typedef struct { bool Excited;} Potential;                 
                                                           
typedef Potential *Synapse;                                
                                                           
typedef struct { Synapse s[SPD];} Dendrite;                
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
       Potential State;                                    
       Dendrite Proximal[PPP];                             
       Dendrite Basal[BPP];                                
       Dendrite Apical[APP];                               
     } Pyramidal;                                          
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
         Pyramidal L2[PinL2];                              
         Pyramidal L4[PinL4];                              
         Pyramidal L6[PinL6];                              
         Pyramidal Thalmus[PinTh];                         
     } Minicolumn;                                         
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
void initialize( int argc, char *argv[]){                  
                                                           
                                                           
                                                           
                                                           
  if ( argc > 1 ) {                                        
                                                           
    printf("  initializing\n");                            
    printf("   %s\n",argv[1]);                             
                                                           
                                                           
                                                           
                                                           
  }else{                                                   
    printf("  parameter?\n");                              
  }                                                        
}                                                          
                                                           
                                                           
void iterate(void){                                        
  printf("  iterating\n");                                 
}                                                          
                                                           
                                                           
                                                           
void summarize(void){                                      
  printf("  summarizing\n");                               
}                                                          
                                                           
                                                           
                                                           
int main(int argc, char *argv[]){                          
  printf(" Brainiac\n");                                   
  initialize(argc,argv);                                   
  iterate();                                               
  summarize();                                             
  return(0);                                               
}                                                          
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
