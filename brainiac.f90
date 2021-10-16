!brainiac.f90                                            
PROGRAM Brainiac                                         
implicit none                                            
                                                         
                                                         
                                                         
 integer, parameter :: SPD = 40                          
 integer, parameter :: PPP = 48                          
 integer, parameter :: BPP = 48                          
 integer, parameter :: APP = 48                          
 integer, parameter :: PinL2 = 32                        
 integer, parameter :: PinL4 = 32                        
 integer, parameter :: Acc4  = 32 + PinL2                
 integer, parameter :: PinL5 = 32                        
 integer, parameter :: Acc5  = 32 + Acc4                 
 integer, parameter :: PinL6 = 32                        
 integer, parameter :: Acc6  = 32 + Acc5                 
 integer, parameter :: PinTh = 4                         
 integer, parameter :: AccTh = 4  + Acc6                 
 integer, parameter :: MCinC = 128                       
 integer, parameter :: CinP = 9                          
 integer, parameter :: NP = 152064                       
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
INTEGER(4), DIMENSION(:), ALLOCATABLE :: P               
INTEGER(4), DIMENSION(:), ALLOCATABLE :: S               
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
call begin()                                             
                                                         
CONTAINS                                                 
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  SUBROUTINE la2sa(a,c,mc,lv,lvo)                        
    implicit none                                        
    integer, INTENT(IN) :: a                             
    integer, INTENT(INOUT) :: c,mc,lv,lvo                
    integer :: np,mci,mco,co                             
                                                         
    mci=mod(a,AccTh)                                     
    mco=a / AccTh                                        
    mc =mod(mco,MCinC)                                   
    co =a /(AccTh*MCinC)                                 
    c =mod(co,CinP)                                      
    IF      (mci<PinL2) THEN;lv =0;  lvo =mci            
    ELSE IF (mci<Acc4)  THEN;lv =1;  lvo =mci-PinL2      
    ELSE IF (mci<Acc5)  THEN;lv =2;  lvo =mci-Acc4       
    ELSE IF (mci<Acc6)  THEN;lv =3;  lvo =mci-Acc5       
    ELSE IF (mci<AccTh) THEN;lv =4;  lvo =mci-Acc6       
    ELSE                    ;lv =-1; lvo =-1             
    END IF                                               
                                                         
  END SUBROUTINE                                         
                                                         
  SUBROUTINE initialize( )                               
    implicit none                                        
    character(256) :: arg, td, tp                        
    integer :: icount, dp,    astat,i,c,mc,lv,lvo        
                                                         
    icount = iargc()                                     
    if ( icount.gt.0 ) then                              
      call getarg(1, arg)                                
      print *,' initializing ', TRIM(arg)                
      td="-9-128-4-32-32-32-32-48-48-48-40-0-0-0.dnd"    
      tp="-9-128-4-32-32-32-32-0-0-0.pex"                
      open (1,file="b-"//TRIM(arg)//tp, status = 'old')  
      open (2,file="b-"//TRIM(arg)//td, status = 'old')  
                                                         
                                                         
      dp= SPD+PPP+BPP+APP                                
                                                         
      print *,'  dendrites:', dp*NP                      
      print *,'  p cells  :', NP                         
      print *,'  miniclmns:', CinP*MCinC                 
      ALLOCATE ( P(NP*dp), STAT = astat)                 
      IF (astat /= 0) STOP "*** OOM ***"                 
      ALLOCATE ( S(np),    STAT = astat)                 
      IF (astat /= 0) STOP "*** OOM ***"                 
      DO i=0,NP-1                                        
        call la2sa(i,c,mc,lv,lvo)                        
!       print *,'--',i,c,mc,lv,lvo                       
                                                         
                                                         
      END DO                                             
                                                         
                                                         
                                                         
                                                         
    else                                                 
      print *,' parameter?'                              
    endif                                                
    RETURN                                               
  END SUBROUTINE                                         
                                                         
                                                         
                                                         
  SUBROUTINE iterate( )                                  
    implicit none                                        
    print *,' iterating'                                 
    RETURN                                               
  END SUBROUTINE                                         
                                                         
  SUBROUTINE summarize( )                                
    implicit none                                        
    print *,' summarizing'                               
    RETURN                                               
  END SUBROUTINE                                         
                                                         
  SUBROUTINE begin( )                                    
    print *,'Brainiac'                                   
    call initialize()                                    
    call iterate()                                       
    call summarize()                                     
                                                         
                                                         
                                                         
                                                         
                                                         
  END SUBROUTINE                                         
END PROGRAM Brainiac                                     
                                                         
                                                         
                                                         
                                                         
