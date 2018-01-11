 xdef    sturn, portP, portPddr, smflag
 xref	tflag, btflag

variables:  section
smflag:     ds.b    1

constants:  section
portP:      equ     $258
portPddr:   equ     $25A
vals:       dc.b    $0A, $12, $14, $0c  


;Turns the stepper motor once per call like in the lab. Called in RTI.

sturn:  pshx
        pshy
        pshd
        
        
        ldaa	btflag
        cmpa	#0
        beq		fw
        bra		bw
        
bw:		ldaa    smflag
        cmpa    #5
        bne     loop
        ldaa    #1
        staa    smflag
        

loop:   ldx     #vals+3       ;sets x to values
        ldab    #1
loop1:  cmpb    smflag
        beq     done
        incb
        dex
        bra     loop1

 	        
        		

        
fw:     ldaa    smflag
        cmpa    #5
        bne     loop2
        ldaa    #1
        staa    smflag
        

loop2:  ldx     #vals       ;sets x to values
        ldab    #1
loop3:  cmpb    smflag
        beq     done
        incb
        inx
        bra     loop3

  

done:   ldaa    0,x
        staa    portP
        inc     smflag
        puld
        puly
        pulx
        rts

