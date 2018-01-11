  xdef checknm
  xref keypress, Keypad, userupdate, loggeduser, usercount
  
variables:  section
flag:       ds.b  1
temp:       ds.b  1
tempcount:  ds.b  1

constants:  section
table:      dc.b  1,2,3,4,5,6,7,8


;This file checks to see which keypad button is pressed, then displays the correct username accordingly. It will only update
;if a valid button is pressed.

checknm:    pshx
            pshy
            pshd
            ldaa  #0
            staa  flag
            ldaa  usercount
            inca
            staa  tempcount

;check for username choice
spot1:      jsr   Keypad

;Checks to see if choice was 'enter'
            ldaa  keypress
            cmpa  #15
            beq   enter

;Checks to see if choice was 1-5
            ldx   #table
            ldab  #1
spot2:      cmpb  tempcount
            beq   spot1
            ldaa  keypress
            cmpa  0,x
            beq   setflag
            incb
            inx
            bra   spot2

;Checks to see if a username has been selected            
enter:      ldaa  flag
            cmpa  #1
            bne   spot1
            ldaa  temp
            staa  loggeduser
            puld
            puly
            pulx
            rts            
            
;Sets flag once a number 1-5 has been chosen            
setflag:    staa  temp
            ldaa  #1
            staa  flag
            jsr   userupdate    ;updates the LCD
            bra   spot1                 
