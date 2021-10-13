/* brainiac.c */                                           
                                                           
#include <stdbool.h>                                       
#include <stdio.h>                                         
#include <stdlib.h>                                        
                                                           
#define SPD   40  // Synapses per Dendrite                 
#define PPP   48  // Proximal per Pyramidal                
#define BPP   48  // Basal per Pyramidal                   
#define APP   48  // Apical per Pyramidal                  
#define PinL2   32  // Pyramidal in L2                     
#define PinL4   32  // Pyramidal in L4                     
#define PinL5   32  // Pyramidal in L5                     
#define PinL6   32  // Pyramidal in L6                     
#define PinTh   4   // Pyramidal in Thalmus                
#define MCinC   128 // Minicolumns in a Column             
#define CinP    9   // Columns in a Patch                  
                                                           
                                                           
typedef struct { bool Excited;} Potential;                 
                                                           
                                                           
                                                           
typedef int32_t Synapse;                                   
                                                           
                                                           
                                                           
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
         Pyramidal L5[PinL5];                              
         Pyramidal L6[PinL6];                              
         Pyramidal Thalmus[PinTh];                         
     } Minicolumn;                                         
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
         Minicolumn MC[MCinC];                             
     } Column;                                             
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
             Column  C[ CinP];                             
     } Patch;                                              
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
Patch * initialize( int argc, char *argv[]){               
  FILE * fpex; FILE * fdnd; int dp; int np; Patch *P;      
  char  hdr[4096]; char dndfn[1024]; char pexfn[1024];     
  if ( argc > 1 ) {                                        
    printf("  initializing %s\n",argv[1]);                 
    sprintf(dndfn,"b-%s-%s",argv[1],                       
      "9-128-4-32-32-32-32-48-48-48-40-0-0-0.dnd");        
    sprintf(pexfn,"b-%s-%s",argv[1],                       
      "9-128-4-32-32-32-32-0-0-0.pex");                    
    fpex = fopen(pexfn,"r");                               
    if(fpex){                                              
      fdnd = fopen(dndfn,"r");                             
      if(fdnd){                                            
        fgets(hdr,4096,(FILE *)fpex);                      
        dp= SPD+PPP+BPP+APP;                               
        np=(PinL2+PinL4+PinL5+PinL6+PinTh)*MCinC*CinP;     
         printf("   dendrites:    %d\n",dp*np);            
         printf("   p cells  :      %d\n",np);             
         printf("   miniclmns:        %d\n",CinP*MCinC);   
         P = (Patch *)malloc(sizeof(Patch));               
                                                           
      }else{                                               
        printf("  file %s?\n",dndfn);                      
      }                                                    
    }else{                                                 
      printf("  file %s?\n",pexfn);                        
    }                                                      
  }else{                                                   
    printf("  parameter?\n");                              
  }                                                        
  return(P);                                               
}                                                          
                                                           
                                                           
void iterate(Patch *P){                                    
  printf("  iterating\n");                                 
}                                                          
                                                           
                                                           
                                                           
void summarize(Patch *P){                                  
  printf("  summarizing\n");                               
}                                                          
                                                           
                                                           
                                                           
int main(int argc, char *argv[]){                          
  Patch *P;                                                
                                                           
  printf(" Brainiac\n");                                   
  P = initialize(argc,argv);                               
  iterate(P);                                              
  summarize(P);                                            
  return(0);                                               
}                                                          
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
