/* brainiac.c */                                           
#include <stdint.h>                                        
#include <stdbool.h>                                       
#include <stdio.h>                                         
#include <stdlib.h>                                        
                                                           
#define PYRAMIDAL 0                                        
#define INHIBITOR 1                                        
#define SPD   40  // Synapses per Dendrite                 
#define DSZ   40 * 4 // 32 bits per Synapse                
#define PPP   32  // Proximal per Pyramidal                
#define BPP   32  // Basal per Pyramidal                   
#define APP   32  // Apical per Pyramidal                  
#define DPN   32 + 32 + 32                                 
#define PinL2   28  // Pyramidal in L2                     
#define Acc2    28                                         
#define PinL4   28  // Pyramidal in L4                     
#define Acc4    56                                         
#define PinL5   28  // Pyramidal in L5                     
#define Acc5    84                                         
#define PinL6   28  // Pyramidal in L6                     
#define Acc6    112                                        
#define PinTh   4   // Pyramidal in Thalmus                
#define AccTh   116                                        
#define MCinC   96 // 128 // Minicolumns in a Column       
#define CinP    9   // Columns in a Patch                  
#define NP      100224 // 152064                           
#define brainN  10000000000 // neurons in the cortex       
#define brainP  100000 // patches in the cortex            
#define flyN    200000 // 50% Central vs Optic             
#define flyS    800 // synapses per neuron                 
#define brainS  30000 // synapses per pyramidal neuron     
#define DforSp  135 // 20 of 135 act clustered fr spike?   
#define NtoN    5 // avg syn contacts axon2axon            
#define CforSp  20 // 20 connections per spike?            
                                                           
typedef int32_t Potential;                                 
                                                           
                                                           
                                                           
typedef int32_t Synapse;                                   
                                                           
                                                           
                                                           
typedef struct { Synapse s[SPD];} Dendrite;                
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
       uint16_t Kind;                                      
                                                           
       uint16_t State;                                     
                                                           
       Dendrite De[DPN];                                   
                                                           
                                                           
     } Neuron;                                             
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
         Neuron     N[AccTh];                              
                                                           
                                                           
                                                           
                                                           
     } Minicolumn;                                         
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
         Minicolumn MC[MCinC];                             
     } Column;                                             
                                                           
                                                           
                                                           
                                                           
                                                           
typedef struct {                                           
             Column  C[ CinP];                             
     } Patch;                                              
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
  void la2sa( int a,int*c,int*mc,int*ni,int*lv,int*lvo ){  
    *ni = a % AccTh;                                       
    int mco = a  / AccTh; *mc = mco % MCinC;               
    int co = a / (AccTh*MCinC); *c= co % CinP;             
    if      (*ni<PinL2) {*lv=0;  *lvo=*ni;                 
    }else if(*ni<Acc4)  {*lv=1;  *lvo=*ni-PinL2;           
    }else if(*ni<Acc5)  {*lv=2;  *lvo=*ni-Acc4;            
    }else if(*ni<Acc6)  {*lv=3;  *lvo=*ni-Acc5;            
    }else if(*ni<AccTh) {*lv=4;  *lvo=*ni-Acc6;            
    }else               {*lv=-1; *lvo=-1;                  
    }                                                      
  }                                                        
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
Patch * initialize( int argc, char *argv[]){               
  FILE * fpex; FILE * fdnd; int dp,   i,j ; Patch *P;      
  char  hdr[4096]; char dndfn[1024]; char pexfn[1024];     
  if ( argc > 1 ) {                                        
    printf("  initializing %s\n",argv[1]);                 
    sprintf(dndfn,"b-%s-%s",argv[1],                       
      "9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd");         
    sprintf(pexfn,"b-%s-%s",argv[1],                       
      "9-96-4-28-28-28-28-0-0-0.pex");                     
    fpex = fopen(pexfn,"r");                               
    if(fpex){                                              
      fdnd = fopen(dndfn,"r");                             
      if(fdnd){                                            
        fgets(hdr,4096,(FILE *)fpex);                      
        dp= SPD+PPP+BPP+APP;                               
         printf("   dendrites:    %d\n",dp*NP);            
         printf("   p cells  :      %d\n",NP);             
         printf("   miniclmns:         %d\n",CinP*MCinC);  
         printf("   loading...\n");                        
         P = (Patch *)malloc(sizeof(Patch));               
         int c,mc,ni,lv,lvo; uint16_t x;                   
         Neuron    *n; Dendrite *pd,*bd,*ad;               
         for(i=0;i<NP;i++){                                
           la2sa(i,&c,&mc,&ni,&lv,&lvo);                   
           n=&(P->C[c].MC[mc].N[ni]); n->State=x;          
           if (fread (&x, 1, sizeof x, fpex) != sizeof x) {
              printf("  read pex kind?\n"); exit(1);       
           }                                               
           n->Kind =x;                                     
           if (fread (&x, 1, sizeof x, fpex) != sizeof x) {
              printf("  read pex state?\n"); exit(1);      
           }                                               
           n->State=x;                                     
           if (fread(n->De,1,DPN*DSZ,fdnd) != DPN*DSZ) {   
              printf("  read dnd?\n"); exit(1);            
           }                                               
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
//   printf("--%d,%d,%d,%d,%d,%d,%d\n",i,c,mc,ni,lv,lvo,x);
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
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
                                                           
