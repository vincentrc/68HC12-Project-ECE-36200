    xdef	diffset, differential, scopeflag, interval, yrinterval, remainder
	xref	switchdif, potdif, seconds, minutes, hours, days, months, years
	xref	dseconds, dminutes, dhours, ddays, dmonths, dyears, monthl, tflag, btflag	



variables:	section
differential:	ds.b	1
secondsdif:   ds.w  1
minutesdif:   ds.w  1
hoursdif:     ds.w  1
daysdif:      ds.w  1
monthsdif:    ds.w  1
yearsdif:     ds.w  1
scopeflag:    ds.b  1
temp:         ds.w  1 
dtemp:	ds.w	1
result:       ds.b  1
yrinterval:	ds.w	1
interval:	ds.b	1
remainder:	ds.w	1
fixer:	ds.w	1	 


constants:	section
dummy:	dc.b	1


;This file sets up all of the variables for the time differential. It calculates the direction of travel, the difference between the 
;current and destination time, an interval of one tenth of that difference for the ramp up/down, and the scope of the time travel.
;Scope meaning what unit is the interval calculated in (hours, minutes, days, etc.)

diffset:    pshd
            pshx
            pshy
            
            
;check direction of travel            
dircheck:   ldd   years
            subd  dyears
            beq   checkmo
            bmi   forw
            lbra  backw
            
checkmo:    ldaa  months
            suba  dmonths
            beq   checkda
            bmi   forw
            lbra  backw
            
            
checkda:    ldaa  days
            suba  ddays
            beq   checkhr
            bmi   forw
            lbra  backw
            
         
checkhr:    ldaa  hours
            suba  dhours
            beq   checkmi
            bmi   forw
            lbra  backw
            
            
checkmi:    ldaa  minutes
            suba  dminutes
            beq   checkse
            bmi   forw
            lbra  backw
            
            
checkse:    ldaa  seconds
            suba  dseconds
            bmi   forw
            lbra  backw                        



;Sets up scope and intervals (forward) 
forw:       ldaa  #1
            staa  tflag
            ldaa  #0
            staa  btflag
            
yearsc:     ldd   dyears
            subd  years
            std   yearsdif
            cpd   #10
            blo   monthsc
            ldx		#10
            idiv
            stx	yrinterval
            std	remainder
            ldaa	#0
            staa	scopeflag
            lbra	endforw
            
            
monthsc:    ldaa	months
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dmonths
			staa	dtemp+1	
			ldd  	yearsdif
            ldy		#12
            emul
            subd	temp
            addd	dtemp
            std		monthsdif
            cpd		#10
            blo		daysc
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#1
            staa	scopeflag
            lbra	endforw
            
daysc:      ldaa	days
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	ddays
			staa	dtemp+1	
			ldd  	monthsdif
            ldy		#30
            emul
            subd	temp
            addd	dtemp
            std		daysdif
            cpd		#10
            blo		hoursc
            ldx		#10
            idiv	
            std 	remainder
            tfr		x,d		
            stab	interval
            ldaa	#2
            staa	scopeflag
            lbra	endforw
			
hoursc:		ldaa	hours
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dhours
			staa	dtemp+1	
			ldd  	daysdif
            ldy		#24
            emul
            subd	temp
            addd	dtemp
            std		hoursdif
            cpd		#10
            blo		minutesc
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#3
            staa	scopeflag
            lbra	endforw
            
minutesc:	ldaa	minutes
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dminutes
			staa	dtemp+1	
			ldd  	hoursdif
            ldy		#60
            emul
            subd	temp
            addd	dtemp
            std		minutesdif
            cpd		#10
            blo		secondsc
            ldx		#10
            idiv
            std	remainder	
            tfr		x,d		
            stab	interval
            ldaa	#4
            staa	scopeflag
            lbra	endforw
			
secondsc:	ldaa	seconds
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dseconds
			staa	dtemp+1	
			ldd  	minutesdif
            ldy		#60
            emul
            subd	temp
            addd	dtemp
            std		secondsdif
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#5
            staa	scopeflag
            lbra	endforw
			

     
endforw:   	puly
			pulx
			puld
			rts

;Sets up difference roughly (backwards)
backw:      ldaa  #0
            staa  tflag
            ldaa  #1
            staa  btflag
            
            
byearsc:     ldd   years
            subd  dyears
            std   yearsdif
            cpd   #10
            blo   bmonthsc
            ldx		#10
            idiv
            std	remainder
            stx		yrinterval
            ldaa	#0
            staa	scopeflag
            lbra	endbackw
            
            
bmonthsc:    ldaa	months
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dmonths
			staa	dtemp+1	
			ldd  	 yearsdif
            ldy		#12
            emul
            subd	dtemp
            addd	temp
            std		monthsdif
            cpd		#10
            blo		bdaysc
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#1
            staa	scopeflag
            lbra	endbackw
            
bdaysc:      ldaa	days
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	ddays
			staa	dtemp+1	
			ldd  	monthsdif
            ldy		#30
            emul
            subd	dtemp
            addd	temp
            std		daysdif
            cpd		#10
            blo		bhoursc
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#2
            staa	scopeflag
            lbra	endbackw
			
bhoursc:		ldaa	hours
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dhours
			staa	dtemp+1	
			ldd  	daysdif
            ldy		#24
            emul
            subd	dtemp
            addd	temp
            std		hoursdif
            cpd		#10
            blo		bminutesc
            ldx		#10
            idiv
            std	remainder	
            tfr		x,d		
            stab	interval
            ldaa	#3
            staa	scopeflag
            lbra	endbackw
            
bminutesc:	ldaa	minutes
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dminutes
			staa	dtemp+1	
			ldd  	hoursdif
            ldy		#60
            emul
            subd	dtemp
            addd	temp
            std		minutesdif
            cpd		#10
            blo		bsecondsc
            ldx		#10
            idiv	
            std	remainder
            tfr		x,d		
            stab	interval
            ldaa	#4
            staa	scopeflag
            lbra	endbackw
			
bsecondsc:	ldaa	seconds
			staa	temp+1
			ldaa	#0
			staa	temp
			staa	dtemp
			ldaa	dseconds
			staa	dtemp+1	
			ldd  	minutesdif
            ldy		#60
            emul
            subd	dtemp
            addd	temp
            std		secondsdif
            ldx		#10
            idiv
            std	remainder	
            tfr		x,d		
            stab	interval
            ldaa	#5
            staa	scopeflag
            lbra	endbackw
           
            
endbackw:   puly
			pulx
			puld
			rts          

