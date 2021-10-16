/* brainiac.c */                                           
#include <stdint.h>                                        
#include <stdbool.h>                                       
#include <stdio.h>                                         
#include <stdlib.h>                                        
                                                           
#define SPD   40  // Synapses per Dendrite                 
#define PPP   48  // Proximal per Pyramidal                
#define BPP   48  // Basal per Pyramidal                   
#define APP   48  // Apical per Pyramidal                  
#define PinL2   32  // Pyramidal in L2                     
#define PinL4   32  // Pyramidal in L4                     
#define Acc4    64                                         
#define PinL5   32  // Pyramidal in L5                     
#define Acc5    96                                         
#define PinL6   32  // Pyramidal in L6                     
#define Acc6    128                                        
#define PinTh   4   // Pyramidal in Thalmus                
#define AccTh   132                                        
#define MCinC   128 // Minicolumns in a Column             
#define CinP    9   // Columns in a Patch                  
#define NP      152064                                     
                                                           
                                                           
                                                           
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
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
void la2sa( int a,int*c,int*mc,int*lv,int*lvo ){           
                             int mci = a  % AccTh;         
  int mco = a  / AccTh; *mc = mco % MCinC;                 
  int co = a / (AccTh*MCinC); *c= co % CinP;               
  if      (mci<PinL2) {*lv=0;  *lvo=mci;                   
  }else if(mci<Acc4)  {*lv=1;  *lvo=mci-PinL2;             
  }else if(mci<Acc5)  {*lv=2;  *lvo=mci-Acc4;              
  }else if(mci<Acc6)  {*lv=3;  *lvo=mci-Acc5;              
  }else if(mci<AccTh) {*lv=4;  *lvo=mci-Acc6;              
  }else               {*lv=-1; *lvo=-1;                    
  }                                                        
}                                                          
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
Patch * initialize( int argc, char *argv[]){               
  FILE * fpex; FILE * fdnd; int dp,   i,j ; Patch *P;      
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
                                                           
         printf("   dendrites:    %d\n",dp*NP);            
         printf("   p cells  :      %d\n",NP);             
         printf("   miniclmns:        %d\n",CinP*MCinC);   
         P = (Patch *)malloc(sizeof(Patch));               
         int c,mc,lv,lvo;                                  
         for(i=0;i<NP;i++){                                
           la2sa(i,&c,&mc,&lv,&lvo);                       
      //   printf("--%d,%d,%d,%d,%d\n",i,c,mc,lv,lvo);     
                                                           
         }                                                 
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
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
