		 xdef optionmenu, choice
         xref pot_value,adjustpotval,read_pot,strings
         
variable: SECTION
choice:   ds.b    1


constants:  section
table:      dc.b  1 ;not sure why but variables don't work without this constant section         
 
 ;This is the file for the main option menu that determines which label to branch to in main 
 ;so it calls the correct subroutine
 
 
optionmenu:	  ldaa  #3
			  ldab  #0
			  jsr   strings
			  jsr   read_pot
			  jsr   adjustpotval
			  ldd	pot_value
			  subd	#35		
			  lble	option1
			  ldd	pot_value
			  subd	#80		
			  lble	option2
			  ldd	pot_value
			  subd	#125		
			  lble	option3
			  ldd	pot_value
			  subd	#170		
			  lble	option4
			  ldd	pot_value
			  subd	#210		
			  lble	option5
			  ldd	pot_value
			  subd	#255		
			  lble	option6
			  
			  
			  
option1:	ldaa #3
			ldab #1
			stab choice
			jsr  strings
			rts

option2:	ldaa #3
			ldab #2
			stab choice
			jsr  strings
			rts
			
option3:	ldaa #3
			ldab #3
			stab choice
			jsr  strings
			rts
			
option4:	ldaa #3
			ldab #4
			stab choice
			jsr  strings
			rts
			
option5:	ldaa #3
			ldab #5
			stab choice
			jsr  strings
			rts
			
option6:	ldaa #3
			ldab #6
			stab choice
			jsr  strings
			rts
