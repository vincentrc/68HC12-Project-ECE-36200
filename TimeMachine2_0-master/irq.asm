                 xdef   irq                                                                                                          
                 xref   loggeduser,mode,emergency
                 
                
                 
irq:   ldab  #0
       cmpb  mode
       beq   restmode
       movb  #0,loggeduser      ;log out user
       movb  #0,mode            ;stop travelmode
       movb  #1,emergency       ;set emergency variable for scenario
       rti
       
       
restmode:   movb  #2,emergency  ;set emergency variable for scenario
            rti
