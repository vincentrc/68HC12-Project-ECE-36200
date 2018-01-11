				xdef  travelmode
			xref seconds, minutes, hours, days, months, years,btflag 
			xref	dseconds, dminutes, dhours, ddays, dmonths, dyears, yearsdif, monthsdif, daysdif, hoursdif, minutesdif, secondsdif	 
			xref	sseconds, sminutes, shours, sdays, smonths, syears, interval, f1, f2, f3, f4, fmax, scopeflag, tflag,loggeduser,userupdate
			xref	yrinterval, pacount, display_string, adjustpotval, ton, toff, lcdstring, pot_value, prevpot, stpcnt
			xref  speakvar, emergency, tcount, tempon, tdflag, bigboy, tempoff, travelnote, read_pot, supremecount, eightnote, remainder
			xref  timeinc,timedec,dt1,dt2,dt3,dt4,strings
variables:	section
temp:	ds.w	1
tempf:	ds.w	1

constants:	section
dummy:	dc.b	1

;This file loops while the time machine is in travel mode. It calculates which part of the time differential
;graph you are currently in by using the interval from differentialsetup, and comparing it to how much time 
;has passed. Then, according to the result, sets a flag that lets timeinc/timedec know what percent of the 
;max differential to use when determining whether or not to inc/dec time. After the target time is reached,
;The flags are reset to allow time to pass nomally again. Basically all this code does is loop, evaluate 
;the time, and set flags accordingly that tell the program how fast to move time. Time inc/dec do all of 
;the actual time manipulation.
			
travelmode: jsr read_pot
			jsr adjustpotval
			
			ldx pot_value
			cpx prevpot
			lbeq  samepot
			
			  movb  #15,tempoff
			  movb  #0,tempon
			  movb  #15,toff
			  movb  #0,ton
			  ldd	pot_value
			  subd	#16	
			  lble	onoffset
			  movb  #14,tempoff
			  movb  #1,tempon
			  movb  #14,toff
			  movb  #1,ton
			  ldd	pot_value
			  subd	#32	
			  lble	onoffset
			  movb  #13,tempoff
			  movb  #2,tempon
			  movb  #13,toff
			  movb  #2,ton
			  ldd	pot_value
			  subd	#48	
			  lble	onoffset
			  movb  #12,tempoff
			  movb  #3,tempon
			  movb  #12,toff
			  movb  #3,ton
			  ldd	pot_value
			  subd	#64	
			  lble	onoffset
			  movb  #11,tempoff
			  movb  #4,tempon
			  movb  #11,toff
			  movb  #4,ton
			  ldd	pot_value
			  subd	#80	
			  lble	onoffset
			  movb  #10,tempoff
			  movb  #5,tempon
			  movb  #10,toff
			  movb  #5,ton
			  ldd	pot_value
			  subd	#96	
			  lble	onoffset
			  movb  #9,tempoff
			  movb  #6,tempon
			  movb  #9,toff
			  movb  #6,ton
			   ldd	pot_value
			  subd	#112	
			  lble	onoffset
			  movb  #8,tempoff
			  movb  #7,tempon
			  movb  #8,toff
			  movb  #7,ton
			   ldd	pot_value
			  subd	#128	
			  lble	onoffset
			  movb  #7,tempoff
			  movb  #8,tempon
			  movb  #7,toff
			  movb  #8,ton
			   ldd	pot_value
			  subd	#144	
			  lble	onoffset
			  movb  #6,tempoff
			  movb  #9,tempon
			  movb  #6,toff
			  movb  #9,ton
			   ldd	pot_value
			  subd	#160	
			  lble	onoffset
			  movb  #5,tempoff
			  movb  #10,tempon
			  movb  #5,toff
			  movb  #10,ton
			   ldd	pot_value
			  subd	#176	
			  lble	onoffset
			  movb  #4,tempoff
			  movb  #11,tempon
			  movb  #4,toff
			  movb  #11,ton
			   ldd	pot_value
			  subd	#192	
			  lble	onoffset
			  movb  #3,tempoff
			  movb  #12,tempon
			  movb  #3,toff
			  movb  #12,ton
			   ldd	pot_value
			  subd	#208	
			  lble	onoffset
			  movb  #2,tempoff
			  movb  #13,tempon
			  movb  #2,toff
			  movb  #13,ton
			  ldd	pot_value
			  subd	#224	
			  lble	onoffset
	     	  movb  #1,tempoff
			  movb  #14,tempon
			  movb  #1,toff
			  movb  #14,ton
			  subd	#240	
			  lble	onoffset
		   	  movb  #0,tempoff
			  movb  #15,tempon
			  movb  #0,toff
			  movb  #15,ton	
			  
onoffset:	  
			;d/x->x
			movb #0,stpcnt
			movb #0,tcount
			ldx pot_value
			ldd bigboy
			inx
			idiv
			stx supremecount
			
samepot:    ldd #lcdstring
			jsr display_string
			ldd pot_value
			std prevpot
			
			ldaa	tflag
			cmpa	#1
			beq		forflg
			lbra	bckflg
			
;this part sets the appropriate flag

;forwards in time			
forflg:		ldaa	scopeflag
			cmpa	#0
			lbeq	scyr
			cmpa	#1
			lbeq	scmo
			cmpa	#2
			lbeq	scda
			cmpa	#3
			lbeq	schr
			cmpa	#4
			lbeq	scmi
			cmpa	#5
			
			
;years			
scyr:			ldd		syears
			addd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lbhi	yr2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
yr2:			ldd		syears
			addd	yrinterval
			addd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lbhi	yr3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
yr3:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lbhi	yr4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
yr4:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			std	temp
			ldd	years
			cpd	temp
			lbhi	yr5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
yr5:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			std	temp
			ldd	years
			cpd	temp
			lbhi	yr6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
yr6:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	remainder
			std	temp
			ldd	years
			cpd	temp
			lbhi	yr7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
yr7:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	remainder
			std	temp
			ldd	years
			cpd	temp
			lbhi	yr8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
yr8:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	remainder
			std	temp
			ldd	years
			cpd	temp
			lbhi	yr9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
yr9:		ldd		syears
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	yrinterval
			addd	remainder
			std	temp
			ldd	years
			cpd	temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			


;months
scmo:		ldx     #0
            ldab    interval
            abx     
            stx     temp   
            ldd     pacount
			cpd    temp
			lbhi	mo2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
mo2:		ldx     #0
            ldab    interval
            abx
            abx     
            stx     temp   
            ldd     pacount
			cpd  	temp
			lbhi	mo3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mo3:		ldx     #0
            ldab    interval
            abx 
            abx
            abx    
            stx     temp   
            ldd     pacount
		cpd  	temp
		lbhi	mo4
		ldaa	#1
		staa	f3
		ldaa	#0
		staa	f1
		staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mo4:		ldx     #0
            ldab    interval
            abx  
            abx
            abx
            abx   
            stx     temp   
            ldd     pacount
			cpd  	temp
			lbhi	mo5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
mo5:		ldx     #0
            ldab    interval
            abx 
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd  	temp
			lbhi	mo6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
mo6:		ldx     remainder
            ldab    interval
            abx
            abx
            abx
            abx
            abx
            abx  
            abx 
              
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mo7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
mo7:		ldx     remainder
            ldab    interval
            abx 
            abx
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mo8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
mo8:		ldx     remainder
            ldab    interval
            abx
            abx
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mo9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mo9:		ldx     remainder
            ldab    interval
            abx 
            abx
            abx
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;days			
scda:		ldx     #0
            ldab    interval
            abx     
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
da2:		ldx     #0
            ldab    interval
            abx  
            abx   
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
da3:		ldx     #0
            ldab    interval
            abx 
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
da4:		ldx     #0
            ldab    interval
            abx 
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
da5:	    ldx     #0
            ldab    interval
            abx
            abx
            abx
            abx
            abx     
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
da6:		ldx     remainder
            ldab    interval
            abx 
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
da7:		ldx     remainder
            ldab    interval
            abx 
            abx
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
da8:		ldx     remainder
            ldab    interval
            abx
            abx
            abx
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	da9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
da9:		ldx     remainder
            ldab    interval
            abx
            abx
            abx
            abx
            abx
            abx
            abx
            abx
            abx     
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;minutes			
scmi:	    ldx     #0
            ldab    interval
            abx     
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mi2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
mi2:	            ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	mi3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mi3:		ldx     #0
            ldab    interval
            abx    
            abx
            abx 
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mi4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mi4:	    ldx     #0
            ldab    interval
            abx   
            abx
            abx
            abx  
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mi5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
mi5:	    ldx     #0
            ldab    interval
            abx   
            abx
            abx
            abx
            abx  
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mi6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
mi6:		ldx     remainder
            ldab    interval
            abx 
            abx
            abx
            abx
            abx
            abx    
            stx     temp   
            ldd     pacount
			cpd    	temp
			lbhi	mi7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
mi7:	 		ldx     remainder
           	 	ldab    interval
           	 	abx     
           		abx
           		abx
           		abx
            	abx
            	abx
            	abx
            	stx     temp   
            	ldd     pacount
			cpd    	temp
			lbhi	mi8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
mi8:			ldx     remainder
            	ldab    interval
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx     
            	stx     temp   
            	ldd     pacount
			cpd    	temp
			lbhi	mi9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
mi9:			ldx     remainder
            	ldab    interval
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx
            	abx    
            	stx     temp   
            	ldd     pacount
			cpd    	temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
			
			
			
;hours
schr:		      ldx     #0
                  ldab    interval
                  abx 
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
hr2:		      ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
hr3:		      ldx     #0
                  ldab    interval
                  abx 
                  abx  
                  abx  
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
hr4:	      	ldx     #0
                  ldab    interval
                  abx 
                  abx   
                  abx
                  abx 
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
hr5:		      ldx     #0
                  ldab    interval
                  abx 
                  abx  
                  abx
                  abx
                  abx  
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
hr6:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx   
                  abx
                  abx
                  abx
                  abx 
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
hr7:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx    
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
hr8:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx  
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx  
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
hr9:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx   
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx 
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend	
			
			
;seconds
scse:	      	ldx     #0
                  ldab    interval
                  abx  
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
se2:		      ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	hr3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
se3:	      	ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  abx
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
se4:		      ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  abx
                  abx
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
se5:		      ldx     #0
                  ldab    interval
                  abx 
                  abx    
                  abx
                  abx
                  abx
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
se6:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx   
                  abx
                  abx
                  abx
                  abx
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
se7:	      	ldx     remainder
                  ldab    interval
                  abx 
                  abx 
                  abx
                  abx
                  abx
                  abx   
                  abx   
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
se8:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx 
                  abx
                  abx
                  abx
                  abx
                  abx 
                  abx   
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	se9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
se9:		      ldx     remainder
                  ldab    interval
                  abx 
                  abx    
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx
                  abx
                  stx     temp   
                  ldd     pacount
			cpd    temp
			lbhi	endchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend	
			
			
		
			
			
			
			
			
			
			
;This is for the last interval, basically finishes when dest. is reached			
endchk:		ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			ldd		years
			cpd		dyears
			lbhi	finish
			cpd     dyears
			bge     yrmo
			lbra	flagend
			
yrmo:		ldaa	months
			cmpa	dmonths
			lbhi	finish
			cmpa    dmonths
			bge     yrda
			lbra	flagend

yrda:		ldaa	days
			cmpa	ddays
			lbhi	finish
			cmpa    ddays
			bge     yrhr
			lbra	flagend
			
yrhr:		ldaa	hours
			cmpa	dhours
			lbhi	finish
			cmpa    dhours
			bge     yrmn
			lbra	flagend
			
yrmn:		ldaa	minutes
			cmpa	dminutes
			lbhi	finish
			cmpa    dminutes
			bge     yrse
			lbra	flagend
			
yrse		ldaa	seconds
			cmpa	dseconds
			lbge	finish
			lbra	flagend	
			
			
			
			
			
			

;backwards in time
bckflg:		ldaa	scopeflag
			cmpa	#0
			lbeq	bayr
			cmpa	#1
			lbeq	bamo
			cmpa	#2
			lbeq	bada
			cmpa	#3
			lbeq	bahr
			cmpa	#4
			lbeq	bami
			cmpa	#5
			lbeq	base
			
			
;years			
bayr:		ldd		syears
			subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
byr2:		ldd		syears
			subd	yrinterval
			subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
byr3:		ldd		syears
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
byr4:		ldd		syears
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
byr5:		ldd		syears
			subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
byr6:		ldd		syears
			subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			subd	yrinterval
			subd	remainder
			subd	yrinterval
			std		temp
			ldd		years
			cpd		temp
			lblo	byr7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
byr7:		ldd		syears
			subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	remainder
			std		temp
			ldd		years
			cpd		temp
			lblo	byr8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
byr8:		ldd		syears
			subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	remainder
			std		temp
			ldd		years
			cpd		temp
			lblo	byr9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
byr9:		ldd		syears
			subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
		    subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	yrinterval
			subd	remainder
			std		temp
			ldd		years
			cpd		temp
			lblo	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;months
bamo:			ldx     #0
            	ldab    interval
            	abx     
            	stx     temp   
            	ldd     pacount
            	cpd	temp
			lbhi	bmo2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
bmo2:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmo3:		ldx     #0
            	ldab    interval
           	 	abx 
           	 	abx
           	 	abx    
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmo4:		ldx     #0
            	ldab    interval
           	 	abx  
           	 	abx
           	 	abx
           	 	abx   
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bmo5:			ldx     #0
            	ldab    interval
           	 	abx 
           	 	abx
           	 	abx
           	 	abx
           	 	abx    
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bmo6:			ldx     remainder
            	ldab    interval
           	 	abx 
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx    
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bmo7:			ldx     remainder
            	ldab    interval
           	 	abx  
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx   
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bmo8:			ldx     remainder
            	ldab    interval
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx     
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmo9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmo9:			ldx     remainder
            	ldab    interval
           	 	abx    
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx 
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;days
bada:		ldx     #0
            	ldab    interval
           	 	abx     
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
bda2:		ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bda3:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bda4:			ldx     #0
            	ldab    interval
           	 	abx   
           	 	abx
           	 	abx
           	 	abx  
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bda5:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bda6:			ldx     remainder
            	ldab    interval
           	 	abx   
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx  
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bda7:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bda8:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bda9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bda9:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;hours
bahr:			ldx     #0
            	ldab    interval
           	 	abx     
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
bhr2:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bhr3:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bhr4:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bhr5:			ldx     #0
            	ldab    interval
           	 	abx 
           	 	abx
           	 	abx
           	 	abx
           	 	abx    
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bhr6:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bhr7:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bhr8:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bhr9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bhr9:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;minutes
bami:			ldx     #0
            	ldab    interval
           	 	abx     
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
bmi2:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmi3:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmi4:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bmi5:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bmi6:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bmi7:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bmi8:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bmi9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bmi9:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
			
;seconds
base:			ldx     #0
            	ldab    interval
           	 	abx     
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse2
			ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax
			lbeq	flagend
			
bse2:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse3
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bse3:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse4
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bse4:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse5
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bse5:			ldx     #0
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse6
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bse6:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse7
			ldaa	#1
			staa	fmax
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	f2	
			lbeq	flagend
			
bse7:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse8
			ldaa	#1
			staa	f4
			ldaa	#0
			staa	f1
			staa	f3
			staa	f2
			staa	fmax	
			lbeq	flagend
			
bse8:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bse9
			ldaa	#1
			staa	f3
			ldaa	#0
			staa	f1
			staa	f2
			staa	f4
			staa	fmax	
			lbeq	flagend
			
bse9:			ldx     remainder
            	ldab    interval
           	 	abx     
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
           	 	abx
            	stx     temp   
           		ldd     pacount
           		cpd	temp
			lbhi	bendchk
			ldaa	#1
			staa	f2
			ldaa	#0
			staa	f1
			staa	f3
			staa	f4
			staa	fmax	
			
	
	
bendchk:		ldaa	#1
			staa	f1
			ldaa	#0
			staa	f2
			staa	f3
			staa	f4
			staa	fmax	
			ldd		years
			cpd		dyears
			blo		finish
			cpd	    dyears
			ble		byrmo
			lbra	flagend
			
byrmo:		ldaa	months
			cmpa	dmonths
			blo		finish
			cmpa    dmonths
			ble		byrda
			lbra	flagend

byrda:		ldaa	days
			cmpa	ddays
			blo		finish
			cmpa    ddays
			ble		byrhr
			lbra	flagend
			
byrhr:		ldaa	hours
			cmpa	dhours
			blo		finish
			cmpa    dhours
			ble		byrmn
			lbra	flagend
			
byrmn:		ldaa	minutes
			cmpa	dminutes
			blo		finish
			cmpa    dminutes
			ble		byrse
			lbra	flagend
			
byrse		ldaa	seconds
			cmpa	dseconds
			ble		finish
			lbra	flagend
			
			
			
			
			
;code for once destination has been reached			
finish:		ldaa	#0
			staa	tflag
			staa	btflag
			movb #0,tdflag
			ldd		dyears		;this part is only for the display in case the time goes a a bit over/under
			std		years		
			ldaa	dmonths
			staa	months
			ldaa	ddays
			staa	days
			ldaa	dhours
			staa	hours
			ldaa	dminutes
			staa	minutes
			ldaa	dseconds
			staa	seconds
			
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
			lbra	trvldn
			
			
			
flagend:	ldaa emergency
			cmpa #0
			lbeq  travelmode
			ldaa	#0
			staa	tflag
			staa	btflag
			movb #0,tdflag
			movb #0,loggeduser
			ldaa  #1
            jsr userupdate
			movb #1,eightnote
			movb #1,speakvar
			
trvldn:   	movb #0,travelnote
			ldx  #8192
			stx  supremecount
			movb  #5,tempoff
			movb  #10,tempon
		    movb  #5,toff
			movb  #10,ton
			movb #0,tdflag
			ldx #0
			stx pacount
		    rts
