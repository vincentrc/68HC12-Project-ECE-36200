    xdef  seconds, minutes, hours, days, months, years, setclock, tflag, monthl
    xdef	sseconds, sminutes, shours, sdays, smonths, syears
      xref  strings, lcdstring, display_string, Keypad, waitrelease, ndata, keypress, convert
      
      
variables:  section
seconds:    ds.b  1
minutes:    ds.b  1
hours:      ds.b  1
days:       ds.b  1
months:     ds.b  1
years:      ds.w  1
count:      ds.b  1
temp        ds.b  5
tflag:      ds.b  1
sseconds:	ds.b	1
sminutes	ds.b	1
shours:		ds.b	1
sdays:		ds.b	1
smonths:	ds.b	1
syears:		ds.w	1	



constants:  section
bfour:      dc.b  31
monthl:     dc.b  31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31


;This routine lets the user set the date and time, and saves their entries. It displays what they are entering on the LCD.

setclock:   pshx
            pshy
            pshd



;Sets seconds
scnds:      ldaa  #6
            ldab  #0
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

sentry:     ldaa  #0
            staa  count
            ldx   #temp
            
s1:         jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   secheck
            ldab  count
            cmpb  #3
            beq   secheck
            ldaa  keypress
            cmpa  #10
            bge   sinv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   secheck
            staa  0,x
            inx
            bra   s1

sinv:       dec   count
            bra   s1            
            
secheck:    ldaa  keypress
            cmpa  #15
            bne   scnds
            ldaa  count
            cmpa  #1
            beq   scnds
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldaa  ndata+1
            cmpa  #60
            bge   scnds              
            staa  seconds
            staa	sseconds

            
            
;Sets minutes            
mnts:       ldaa  #6
            ldab  #1
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

mentry:     ldaa  #0
            staa  count
            ldx   #temp
            
m1:         jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   micheck
            ldab  count
            cmpb  #3
            beq   micheck
            ldaa  keypress
            cmpa  #10
            bge   minv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   micheck
            staa  0,x
            inx
            lbra  m1

minv:       dec   count
            bra   m1            
            
micheck:    ldaa  keypress
            cmpa  #15
            bne   mnts
            ldaa  count
            cmpa  #1
            beq   mnts
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldaa  ndata+1
            cmpa  #60
            bge   mnts              
            staa  minutes
            staa	sminutes    
            
            
            
;Sets hours
hrs:        ldaa  #6
            ldab  #2
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

hentry:     ldaa  #0
            staa  count
            ldx   #temp
            
h1:         jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   hrcheck
            ldab  count
            cmpb  #3
            beq   hrcheck
            ldaa  keypress
            cmpa  #10
            bge   hinv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   hrcheck
            staa  0,x
            inx
            lbra  h1
                            
hinv:       dec   count
            lbra  h1            
            
hrcheck:    ldaa  keypress
            cmpa  #15
            bne   hrs
            ldaa  count
            cmpa  #1
            beq   hrs
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldaa  ndata+1
            cmpa  #24
            bge   hrs              
            staa  hours
            staa	shours
            
            
            
;Sets month
mnth:       ldaa  #6
            ldab  #3
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

montry:     ldaa  #0
            staa  count
            ldx   #temp
            
mo1:        jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   mocheck
            ldab  count
            cmpb  #3
            beq   mocheck
            ldaa  keypress
            cmpa  #10
            bge   moinv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   mocheck
            staa  0,x
            inx
            lbra  mo1
                            
moinv:      dec   count
            lbra  mo1            
            
mocheck:    ldaa  keypress
            cmpa  #15
            bne   mnth
            ldaa  count
            cmpa  #1
            beq   mnth
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldaa  ndata+1
            cmpa  #13
            bge   mnth
            cmpa  #0
            beq   mnth              
            staa  months
            staa	smonths
            
            

;Sets Day
dys:        ldaa  #6
            ldab  #4
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

dentry:     ldaa  #0
            staa  count
            ldx   #temp
            
d1:         jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   dycheck
            ldab  count
            cmpb  #3
            beq   dycheck
            ldaa  keypress
            cmpa  #10
            bge   dinv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   dycheck
            staa  0,x
            inx
            lbra  d1
                            
dinv:       dec   count
            lbra  d1            
            
dycheck:    ldaa  keypress
            cmpa  #15
            bne   dys
            ldaa  count
            cmpa  #1
            beq   dys
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldaa  ndata+1
            cmpa  #0
            beq   dys
            ldx   #monthl
            ldab  #1
mset:       cmpb  months
            beq   mdone
            incb
            inx
            bra   mset                 
mdone:      deca
            cmpa  0,x
            lbge  dys  
            inca            
            staa  days
            staa	sdays
            
            
;Sets years
yrs:        ldaa  #6
            ldab  #5
            jsr   strings
            ldd   #lcdstring
            jsr   display_string

yentry:     ldaa  #0
            staa  count
            ldx   #temp
            
y1:         jsr   Keypad
            jsr   waitrelease 
            inc   count
            ldaa  keypress
            cmpa  #15
            beq   yrcheck
            ldab  count
            cmpb  #5
            beq   yrcheck
            ldaa  keypress
            cmpa  #10
            bge   yinv
            ldaa  #5
            jsr   strings
            ldd   #lcdstring
            pshx
            jsr   display_string
            pulx
            ldaa  keypress
            cmpa  #15
            beq   yrcheck
            staa  0,x
            inx
            lbra  y1
                            
yinv:       dec   count
            lbra  y1            
            
yrcheck:    ldaa  keypress
            cmpa  #15
            bne   yrs
            ldaa  count
            cmpa  #1
            beq   yrs
            ldx   #temp
            ldab  count
            decb
            jsr   convert
            ldd   ndata
            cpd   #10000
            bge   yrs              
            std   years
            std		syears
            puld
            puly
            pulx
            rts
            

