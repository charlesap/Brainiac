!brainiac.f90                                            
PROGRAM Brainiac                                         
implicit none                                            
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
 integer, parameter :: PYRAMIDAL = 0                     
 integer, parameter :: INHIBITOR = 1                     
 integer, parameter :: SPD = 40                          
 integer, parameter :: DSZ = 40 * 4                      
 integer, parameter :: PPP = 32                          
 integer, parameter :: BPP = 32                          
 integer, parameter :: APP = 32                          
 integer, parameter :: DPN = 32 + 32 + 32                
 integer, parameter :: PinL2 = 28                        
 integer, parameter :: Acc2  = 28                        
 integer, parameter :: PinL4 = 28                        
 integer, parameter :: Acc4  = 28 + PinL2                
 integer, parameter :: PinL5 = 28                        
 integer, parameter :: Acc5  = 28 + Acc4                 
 integer, parameter :: PinL6 = 28                        
 integer, parameter :: Acc6  = 28 + Acc5                 
 integer, parameter :: PinTh = 4                         
 integer, parameter :: AccTh = 4  + Acc6                 
 integer, parameter :: MCinC = 96                        
 integer, parameter :: CinP = 9                          
 integer, parameter :: NP = 100224                       
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
INTEGER(4), DIMENSION(:), ALLOCATABLE :: P               
INTEGER(4), DIMENSION(:), ALLOCATABLE :: S               
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
call begin()                                             
                                                         
CONTAINS                                                 
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
  SUBROUTINE la2sa(a,c,mc,ni,lv,lvo)                     
    implicit none                                        
    integer, INTENT(IN) :: a                             
    integer, INTENT(INOUT) :: c,mc,ni,lv,lvo             
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
    integer(4) :: x                                      
    real :: tvs,tve                                      
    icount = iargc()                                     
    if ( icount.gt.0 ) then                              
      call getarg(1, arg)                                
      print *,' initializing ', TRIM(arg)                
      call cpu_time(tvs)                                 
      td="-9-96-4-28-28-28-28-32-32-32-40-0-0-0.dnd"     
      tp="-9-96-4-28-28-28-28-0-0-0.pex"                 
      open (1,file="b-"//TRIM(arg)//tp, status = 'old', &
            form='unformatted',access='STREAM')          
      open (2,file="b-"//TRIM(arg)//td, status = 'old', &
                  form='unformatted',access='STREAM')    
      dp= SPD+PPP+BPP+APP                                
      print *,'  dendrites:', dp*NP                      
      print *,'  p cells  :', NP                         
      print *,'  miniclmns:', CinP*MCinC                 
      print *,'  loading...'                             
      ALLOCATE ( P(NP   ), STAT = astat)                 
      IF (astat /= 0) STOP "*** OOM ***"                 
      ALLOCATE ( S(NP*DPN*SPD),    STAT = astat)         
      IF (astat /= 0) STOP "*** OOM ***"                 
      read(1) P                                          
!     DO i=1,NP                                          
!       call la2sa(i-1,c,mc,lv,lvo)                      
!       print *,'--',i-1,c,mc,lv,lvo                     
!     END DO                                             
                                                         
                                                         
      read (2) S                                         
      close (1)                                          
      close (2)                                          
      call cpu_time(tve)                                 
      print *,' MSEC INIT:',tve-tvs                      
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
                                                         
                                                         
                                                         
                                                         
