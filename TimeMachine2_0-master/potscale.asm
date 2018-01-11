    xdef potscale, ones, tenths, hundredths
    xref keypress, Keypad2,read_pot,pot_value

varibale:   section
ones:    ds.b  1
tenths:  ds.b  1
hundredths:  ds.b  1
temp:  		ds.b   1

constants:  section
table:      dc.b  1 ;not sure why but variables don't work without this constant section

potscale:   jsr  Keypad2
            ldaa keypress
            cmpa #15
            beq   enter
            rts

;Checks to see if a username has been selected            
enter:      jsr read_pot    ;read potentiometer
            ldd #255        ;load max pot value
            ldx pot_value   ;load in pot value for idiv
            idiv            ;get ones by division
            xgdx
            stab  ones        ;store x into ones
            xgdx
            ldx   #10         ;load into to divide by 25
            idiv            ;divide by 10
            xgdx
            stab    tenths        ;store into tenths
            xgdx
            stab    hundredths
            rts        
