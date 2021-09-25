!brainiac.f90                                            
PROGRAM Brainiac                                         
implicit none                                            
                                                         
                                                         
                                                         
 integer, parameter :: SPD = 40                          
 integer, parameter :: PPP = 48                          
 integer, parameter :: BPP = 48                          
 integer, parameter :: APP = 48                          
 integer, parameter :: PinL2 = 32                        
 integer, parameter :: PinL4 = 32                        
 integer, parameter :: PinL6 = 32                        
 integer, parameter :: PinTh = 4                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
call begin()                                             
                                                         
                                                         
                                                         
                                                         
CONTAINS                                                 
                                                         
  SUBROUTINE initialize( )                               
    implicit none                                        
    character(256) :: arg                                
    integer :: icount                                    
    icount = iargc()                                     
    if ( icount.gt.0 ) then                              
      call getarg(1, arg)                                
                                                         
      print *,' initializing'                            
      print *,arg                                        
                                                         
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
                                                         
                                                         
                                                         
                                                         
