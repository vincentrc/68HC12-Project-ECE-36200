         xdef  checkpass
      xref  keypress, Keypad, strings, loggeduser, display_string, lcdstring, waitrelease
      xref  pass6, pass7, pass8  


variables:  section
count:      ds.b  1
flag1:      ds.b  1


constants:  section

;Passwords for each user:
pass1:      dc.b        1,1,1,1,1
pass2:      dc.b        1,2,3,4,5
pass3:      dc.b        2,2,2,2,2
pass4:      dc.b        3,3,3,3,3
pass5:      dc.b        4,4,4,4,4





checkpass:  pshx
            pshy
            pshd
            
            


;This finds which user is logged in
spot1:      ldaa  #2
            ldab  #0
            jsr   strings
            ldd   #lcdstring
            jsr   display_string
            ldaa  loggeduser
            cmpa  #1
            beq   one
            cmpa  #2
            beq   two
            cmpa  #3
            beq   three
            cmpa  #4
            beq   four
            cmpa  #5
            beq   five
            cmpa  #6
            beq   six
            cmpa  #7
            beq   seven
            cmpa  #8
            beq   eight
            
            
;This sets index at correct password                    
one:        ldx   #pass1
            bra   spot2

two:        ldx   #pass2
            bra   spot2

three:      ldx   #pass3
            bra   spot2

four:       ldx   #pass4
            bra   spot2

five:       ldx   #pass5
            bra   spot2

six:        ldx   #pass6
            bra   spot2

seven:      ldx   #pass7
            bra   spot2
            
            
eight:      ldx   #pass8
            bra   spot2

            
;This checks each digit against the password, and sets a flag if they don't match            
spot2:      ldaa  #0
            staa  flag1
            staa  count 
            
spot3:      jsr   Keypad
            jsr   waitrelease
            inc   count
            ldaa  #2
            ldab  count
            cmpb  #8
            beq   spot1    
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  0,x
            beq   matches
            cmpa  #15
            beq   enter1
            ldaa  #1         ;sets flag to one if digit doesn't match
            staa  flag1
            inx   
            bra   spot3


;Code for if the digit was a match
matches:    inx
            bra   spot3              
            
          
          
;Code for when enter is pressed            
enter1:     ldab  count
            cmpb  #5
            lbne  spot1
            ldab  flag1
            cmpb  #1
            lbeq  spot1
            puld
            puly
            pulx
            rts




