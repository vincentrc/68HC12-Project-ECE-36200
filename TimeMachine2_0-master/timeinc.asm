 XDEF  timeinc, dt1, dt2, dt3, dt4, icount, f1, f2, f3, f4, fmax
  XREF  seconds, minutes, hours, days, years, months, monthl, tflag, strings, tdflag, switchdif, pacount, scopeflag



variables:  section
temp:   ds.b  1
dt1:    ds.b  1
dt2:    ds.b  1
dt3:    ds.b  1
dt4:    ds.b  1
icount:	ds.b	1
f1:		ds.b	1
f2:		ds.b	1
f3:		ds.b	1
f4:		ds.b	1
fmax:	ds.b	1


constants:  section
dummy:  dc.b  1



;This just increments time every time it is called, more or less often depending on the time differential flags.
timeinc:  pshd
          pshx
          pshy
         
        inc		icount
        ldab	icount
        cmpb	#9
        bne		fone
        ldab	#1
        stab	icount
        
;checks which flag is set
fone:		ldaa	f1
		cmpa	#1
		bne	ftwo
		ldaa	icount
		cmpa	#2
		lbge	done2
		lbra	start
		
ftwo:		ldaa	f2
		cmpa	#1
		bne	fthree
		ldaa	icount
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
		ldaa	icount
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
		ldaa	icount
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
		
         
         
         
start:	ldab	switchdif
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
          inca  
          cmpa  #60
          bge   sr
          staa  seconds
          lbra  done   
          
sr:       ldaa  #0
          staa  seconds

          
m:          ldaa	scopeflag
		cmpa	#4
		bne	mskip
		ldd	pacount
		addd	#1
		std	pacount
mskip:	ldaa  minutes
          inca
          cmpa  #60
          bge   mr
          staa  minutes
          lbra  done
          
mr:       ldaa  #0
          staa  minutes

          
h:          ldaa	scopeflag
		cmpa	#3
		bne	hskip
		ldd	pacount
		addd	#1
		std	pacount
hskip:	ldaa  hours
          inca  
          cmpa  #24
          bge   hr
          staa  hours
          lbra  done
          
hr:       ldaa  #0
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
                     
dldone:   ldab  0,x
          incb
          stab  temp
          ldaa  days
          inca  
          cmpa  temp
          beq   dr
          staa  days             
          lbra  done               
          
dr:       ldaa  #0
          staa  days
          
          
mo:         ldaa	scopeflag
		cmpa	#1
		bne	moskip
		ldd	pacount
		addd	#1
		std	pacount
moskip:	ldaa  months
          inca  
          cmpa  #13
          bge   mor
          staa  months
          lbra  done
       
mor:      ldaa  #1
          staa  months
          
ye:       ldx   years
          inx
          cpx   #10000
          bge   yr
          stx   years
          lbra  done
          
yr:         ldaa	scopeflag
		cmpa	#0
		bne	yskip
		ldd	pacount
		addd	#1
		std	pacount
yskip:	ldx   #0
          stx   years
          ldaa  #0
          staa  tflag
   
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
