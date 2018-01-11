                  xdef settimedif
                  xref PTT,switchdif,keypress,Keypad2,waitrelease,strings,lcdstring,display_string
                  
                  
                  
                  
settimedif:    ldab PTT      ;take in switch value   
               stab switchdif
               
               ldab	switchdif
               ldaa	#0
	     	subd	#43		
	 	lble	s
	 	ldab	switchdif
        ldaa	#0
		subd	#85		
	   	lble	m
	   	ldab	switchdif
        ldaa	#0
		subd	#128		
		lble	h
		ldab	switchdif
        ldaa	#0
		subd	#170		
		lble	da
		ldab	switchdif
        ldaa	#0
		subd	#213		
		lble	mo
   		lbra	ye
   		
cont:          jsr  Keypad2
               ldaa keypress
               cmpa #15
               bne  settimedif
               rts
               
s:  ldaa #9
    ldab #1
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
m:  ldaa #9
    ldab #2
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
h:  ldaa #9
    ldab #3
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
da: ldaa #9
    ldab #4
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
mo: ldaa #9
    ldab #5
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
ye: ldaa #9
    ldab #6
    jsr strings
    ldd #lcdstring
    jsr display_string
    bra cont
