!brainiac.f90                                            
PROGRAM Brainiac                                         
implicit none                                            
                                                         
                                                         
                                                         
 integer, parameter :: SPD = 40                          
 integer, parameter :: PPP = 48                          
 integer, parameter :: BPP = 48                          
 integer, parameter :: APP = 48                          
 integer, parameter :: PinL2 = 32                        
 integer, parameter :: PinL4 = 32                        
 integer, parameter :: PinL5 = 32                        
 integer, parameter :: PinL6 = 32                        
 integer, parameter :: PinTh = 4                         
 integer, parameter :: MCinC = 128                       
 integer, parameter :: CinP = 9                          
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
INTEGER(4), DIMENSION(:), ALLOCATABLE :: P               
INTEGER(4), DIMENSION(:), ALLOCATABLE :: S               
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
call begin()                                             
                                                         
CONTAINS                                                 
                                                         
  SUBROUTINE initialize( )                               
    implicit none                                        
    character(256) :: arg                                
    integer :: icount                                    
    integer :: dp                                        
    integer :: np                                        
    integer :: astat                                     
    icount = iargc()                                     
    if ( icount.gt.0 ) then                              
      call getarg(1, arg)                                
                                                         
      print *,' initializing ', TRIM(arg)                
      dp= SPD+PPP+BPP+APP                                
      np=(PinL2+PinL4+PinL5+PinL6+PinTh)*MCinC*CinP      
      print *,'  dendrites:', dp*np                      
      print *,'  p cells  :', np                         
      print *,'  miniclmns:', CinP*MCinC                 
      ALLOCATE ( P(np*dp), STAT = astat)                 
      IF (astat /= 0) STOP "*** OOM ***"                 
      ALLOCATE ( S(np),    STAT = astat)                 
      IF (astat /= 0) STOP "*** OOM ***"                 
                                                         
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
                                                         
                                                         
                                                         
                                                         
