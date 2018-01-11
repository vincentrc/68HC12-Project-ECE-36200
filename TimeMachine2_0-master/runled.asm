        xdef runled
        xref PTS,tflag,btflag
variables:  section
temp:  ds.b  1

constants:  section
null:   dc.b  1          

          
          
runled:  

	     ldaa btflag
	     cmpa #0
	     beq  backwards
	     
	   psha
         pshb
         pshx
         ldaa PTS
         staa temp
         BCLR temp,#%11000000
         ldaa temp
         cmpa #%00100000
         beq  resetportS
         ldab PTS
         andb #%00111111
         ldaa  PTS
         anda #%00111111
         staa temp
         addb temp  
         ldaa PTS
         anda #%10000000
         staa temp
         addb temp
         stab PTS
         pulx
         pulb
         pula
         rts
         
backwards: 
		 psha
         pshb
         pshx
         ldaa PTS
         staa temp
         BCLR temp,#%11000000
         ldaa temp
         cmpa #%00000001
         beq  bresetportS
         ldab PTS
         andb #%00111111
         ldaa 0
         ldx  #2
         idiv
         tfr  x,d
         stab temp
         ldaa PTS
         anda #%10000000
         adda temp
         staa PTS
         pulx
         pulb
         pula
         rts
         
resetportS: ldaa PTS
            anda #%10000000
            adda #1
            staa PTS
            pulx
            pulb
            pula
            rts
            
bresetportS: ldaa PTS
            anda #%10000000
            adda #%00100000
            staa PTS
            pulx
            pulb
            pula
            rts
