  xdef  pass6, pass7, pass8, adduser
  xref  strings, lcdstring, display_string, Keypad, keypress, waitrelease, usercount

variables:  section
pass6:  ds.b  7
pass7:  ds.b  7
pass8:  ds.b  7
count:  ds.b  1
temp:   ds.b  7

constants:  section
null:   dc.b  1

;This routine takes input for a new 4 digit pin for a new user. It displays the buttons entered on the LCD by using the strings
;subroutine. F is used as enter, and invalid entries will not be accepted

adduser:    pshd
            pshx
            pshy
            
            ;Setup
so:         ldaa  #5
            ldab  #0
            jsr   strings
            ldd   #lcdstring
            jsr   display_string
            ldaa  #0
            staa  count
            ldx   #temp
            ldaa  usercount
            cmpa  #8
            lbeq   full
     
;This section just sets up the password and displays on the LCD as the user enters
spot1:      jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldab  count
            cmpb  #5
            beq   entercheck
            ldaa  keypress
            cmpa  #10
            bge   invalid
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            staa  0,x
            inx
            bra   spot1
          
;Tells user if max users are already entered
full:       ldaa  #5
            ldab  #5
            jsr   strings
            ldd   #lcdstring
            jsr   display_string
            
            ;Waits for 'enter' to return to menu
fulloop:    jsr   Keypad
            ldaa  keypress
            cmpa  #15
            bne   fulloop
            puly
            pulx
            puld
            rts 

          
;If a number higher than 9 is entered, don't accept it            
invalid:    dec   count
            bra   spot1            
            
            
;Checks to make sure last entry was enter, then proceeds to actually add user            
entercheck: ldaa  keypress
            cmpa  #15
            bne   so
            ldaa  usercount
            cmpa  #5
            beq   five
            cmpa  #6
            beq   six
            cmpa  #7
            beq   seven
 
;Adds to specific user according to how many exist            
five:       movb  temp, pass6
            movb  temp+1, pass6+1
            movb  temp+2, pass6+2
            movb  temp+3, pass6+3
            inc   usercount
            puly
            pulx
            puld
            rts
            
six:        movb  temp, pass7
            movb  temp+1, pass7+1
            movb  temp+2, pass7+2
            movb  temp+3, pass7+3
            inc   usercount
            puly
            pulx
            puld
            rts
            
seven:      movb  temp, pass8
            movb  temp+1, pass8+1
            movb  temp+2, pass8+2
            movb  temp+3, pass8+3
            inc   usercount
            puly
            pulx
            puld
            rts      
