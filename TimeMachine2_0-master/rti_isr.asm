              xdef rti_isr, stpcnt, called, tcount,notecount,tdflag,supremecount,bigboy,stpcnt,prevpot,dccount
            xref dcmotor, sturn, CRGFLG, PortS, timeinc, tflag,runled,PlayTone
            xref welcome, speaker,fifteennote,eightnote, timedec, btflag


variables:  section
called:     ds.b    1
tdflag:     ds.b    1 
dccount:    ds.w    1
supremecount: ds.w  1
stpcnt:     ds.w    1
notecount:  ds.w    1
tcount:     ds.w    1
prevpot:    ds.w    1
temp:       ds.w    1

constants:  section
bigboy:      dc.w    65000            

;This ISR calls the subroutines that govern the peripherals when appropriate. It also calls timeinc or timedec
;depending on the direction of time travel.

rti_isr:    

			ldaa   tdflag
            cmpa   #1
            bne	   nexflg
            ldaa   eightnote
            cmpa   #0
            bne    nexflg
			pshx
			pshy
			pshd
            jsr    PlayTone
            puld
			pulx
			puly
            
nexflg:     ldaa   fifteennote
            cmpa   #1
            lbne   mayeight
playnote:   ldx    notecount
            ldy    notecount
            iny
            sty    notecount
            cpx    #877
            lbne    playtone
            jsr    speaker
            ldx    #0
            stx    notecount
            
            
playtone:   pshx
			pshy
			pshd
            jsr    PlayTone
            puld
			pulx
			puly
            lbra    sm

mayeight:   ldaa eightnote
            cmpa #1
            beq  playnote 
            
            ldy    dccount
            iny
            sty    dccount
            cpy    #33
            ble   sm
			jsr   dcmotor
			ldx    #0
            stx    dccount
            
sm:         ldx    stpcnt
            ldy    stpcnt
            stx    temp
            iny
            sty    stpcnt
            cpx    supremecount
            lbne   smdone
            ldaa   tdflag
            cmpa   #1
            bne	   notravel
            ldaa   eightnote
            cmpa   #0
            bne    notravel
            jsr    speaker
notravel:   jsr    sturn
            jsr    runled
            ldx    #0
            stx    stpcnt
smdone:                 
       
            
            
time:       ldaa  tflag
            cmpa  #1
            lbne   timedone
            ldx    temp
            cpx    supremecount
            bne    timedone
            jsr    timeinc
timedone:     


btime:		ldaa	btflag
			cmpa	#1
			lbne	btimedone
			ldx		temp
			cpx		supremecount
			bne		btimedone
			jsr		timedec
btimedone:    
                
            
            
done:       movb   #$80, CRGFLG
            RTI



