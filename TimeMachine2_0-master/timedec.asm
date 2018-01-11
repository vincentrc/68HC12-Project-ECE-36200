   XDEF  btflag, timedec, dcount, pacount
  XREF  seconds, minutes, hours, days, years, months, monthl, tflag, strings, dt1, dt2, dt3, dt4, tdflag, switchdif
  XREF	f1, f2, f3, f4, fmax, scopeflag
  


variables:  section
temp:   ds.b  1
btflag: ds.b  1
dcount:	ds.b	1
pacount:    ds.w    1

constants:  section
dummy:  dc.b  1



;This just increments time every time it is called, more or less often depending on the time differential flags. 
timedec:  pshd
          pshx
          pshy
          
        	
        	
   		inc		dcount
        ldab	dcount
        cmpb	#9
        bne		fone
        ldab	#1
        stab	dcount
        
;checks which flag is set
fone:		ldaa	f1
		cmpa	#1
		bne	ftwo
		ldaa	dcount
		cmpa	#2
		lbge	done2
		lbra	start
		
ftwo:		ldaa	f2
		cmpa	#1
		bne	fthree
		ldaa	dcount
		cmpa	#1
		lbeq	start		
		cmpa	#2
		lbeq	done2	
		cmpa	#3
		lbeq	start	
		cmpa	#4
		lbeq	done2	
		cmpa	#5
		lbeq	start	
		cmpa	#6
		lbeq	done2	
		cmpa	#7
		lbeq	start	
		cmpa	#8
		lbeq	done2	        
 
        
fthree:	ldaa	f3
		cmpa	#1
		bne	ffour
		ldaa	dcount
		cmpa	#1
		lbeq	start		
		cmpa	#2
		lbeq	start	
		cmpa	#3
		lbeq	start	
		cmpa	#4
		lbeq	done2	
		cmpa	#5
		lbeq	start	
		cmpa	#6
		lbeq	start	
		cmpa	#7
		lbeq	start	
		cmpa	#8
		lbeq	done2
		
ffour:	ldaa	f4
		cmpa	#1
		bne	start
		ldaa	dcount
		cmpa	#1
		lbeq	start		
		cmpa	#2
		lbeq	start	
		cmpa	#3
		lbeq	start	
		cmpa	#4
		lbeq	done2	
		cmpa	#5
		lbeq	start	
		cmpa	#6
		lbeq	start	
		cmpa	#7
		lbeq	start	
		cmpa	#8
		lbeq	start
        
        
        
        
        
        
start:  	 ldab	switchdif
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
          
          
          
          
          
s:          ldaa	scopeflag
		cmpa	#5
		bne	sskip
		ldd	pacount
		addd	#1
		std	pacount
sskip:	ldaa  seconds
          deca  
          bmi   sr
          staa  seconds
          lbra  done   
          
sr:       ldaa  #59
          staa  seconds

          
m:          ldaa	scopeflag
		cmpa	#4
		bne	mskip
		ldd	pacount
		addd	#1
		std	pacount
mskip:	ldaa  minutes
          deca
          bmi   mr
          staa  minutes
          lbra  done
          
mr:       ldaa  #59
          staa  minutes

          
h:          ldaa	scopeflag
		cmpa	#3
		bne	hskip
		ldd	pacount
		addd	#1
		std	pacount
hskip:	ldaa  hours
          deca  
          bmi   hr
          staa  hours
          lbra  done
          
hr:       ldaa  #23
          staa  hours

          
da:         ldaa	scopeflag
		cmpa	#2
		bne	daskip
		ldd	pacount
		addd	#1
		std	pacount
daskip:	ldx   #monthl
          ldaa  months
          ldab  #1
           
dloop:    cmpb  months
          beq   dldone
          incb
          inx   
          bra   dloop
                     
dldone:   ldab  -1,x
          stab  temp
          ldaa  days
          deca  
          cmpa  #0
          ble   dr
          staa  days             
          lbra  done               
          
dr:       ldaa  temp
          staa  days
          
          
mo:         ldaa	scopeflag
		cmpa	#1
		bne	moskip
		ldd	pacount
		addd	#1
		std	pacount
moskip:	ldaa  months
          deca  
          cmpa  #0
          ble   mor
          staa  months
          lbra  done
       
mor:      ldaa  #12
          staa  months
          
ye:         ldaa	scopeflag
		cmpa	#0
		bne	yskip
		ldd	pacount
		addd	#1
		std	pacount
yskip:	ldx   years
          dex
          cpx   #0
          ble   yr
          stx   years
          lbra  done
          
yr:       ldx   #0
          stx   years
          ldaa  #0
          staa  btflag
   
done:     ldaa  tdflag
          cmpa  #1
          lbne   done2

dones:    ldab  seconds
          ldaa  #0
          ldx   #10
          idiv
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #1
          jsr   strings
     
donem:    ldab  minutes
          ldaa  #0
          ldx   #10
          idiv
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #2
          jsr   strings  
         
doneh:    ldab  hours
          ldaa  #0
          ldx   #10
          idiv
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #3
          jsr   strings
 
donemo:   ldab  months
          ldaa  #0
          ldx   #10
          idiv
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #4
          jsr   strings
          
doned:    ldab  days
          ldaa  #0
          ldx   #10
          idiv
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #5
          jsr   strings

doney:    ldd   years
          ldx   #10
          idiv
          stab  dt4
          tfr   x,d
          ldx   #10
          idiv
          stab  dt3
          tfr   x,d
          ldx   #10
          idiv  
          stab  dt2
          tfr   x,d
          stab  dt1
          ldaa  #7
          ldab  #6
          jsr   strings
done2:    puly
          pulx
          puld
          rts

