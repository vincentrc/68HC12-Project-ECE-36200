        xdef dcmotor,ton,toff,tempoff,tempon,port_tddr,port_t
        xref CRGFLG
        
MY_EXTENDED_RAM: SECTION
ton: ds.b  1
toff: ds.b  1
tempoff: ds.b  1
tempon: ds.b  1

MY_ROM: SECTION
port_tddr:  equ  $242
port_t:  equ  $240        
        
;Turns the DC like in the lab, called in RTI

dcmotor:    ldab   ton
            cmpb   #0
            beq    turnoff
            movb   #$08,port_t
            decb   
            stab   ton
            bra    ending
turnoff:    movb   #$00,port_t
            ldab   toff
            cmpb   #0
            beq    restore
            decb   
            stab   toff
ending:     BSET   CRGFLG, #$80
            rts
restore:    BSET   CRGFLG, #$80
            ldab   tempon     
            stab   ton
            ldab   tempoff
            stab   toff  
            rts
