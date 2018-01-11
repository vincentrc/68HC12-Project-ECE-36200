				xdef displaypot
				xref lcdstring,display_string,read_pot,pot_value


; variable/data section
my_variable: SECTION
digits: ds.b 3

my_constants: SECTION
constant:	dc.b 1
				

displaypot: jsr read_pot    ;read potentiometer
            ldd pot_value   ;load lower value of pot_value
            ldy #3          ;load in 3 to y
bcdloop:    ldx #10         ;load in x for idiv
            idiv            ;divide pot value by 10
            addb #$30       ;add $30 to get correct ASCII displayed
            stab digits-1,y ;store remainder in each digit respectively
            xgdx            ;exchange d with x
            dey             ;decrement y
            bne  bcdloop    ;iterate for 3 digits
            movb digits,lcdstring+17    ;put in hundreds digit
            movb digits+1,lcdstring+18  ;put in tens digit
            movb digits+2,lcdstring+19  ;put in ones digit  
            
            ldd  #lcdstring 
            jsr  display_string     ;display string
            rts  					;branch back to reading potentiometer
