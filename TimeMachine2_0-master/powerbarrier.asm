			xdef powerbarrier, barrier
			xref PTP,PortS

variable: SECTION
barrier:   ds.b    1


constants:  section
table:      dc.b  1 ;not sure why but variables don't work without this constant section        		


			

powerbarrier:	ldaa barrier
                cmpa #0
                beq  barrieroff
                cmpa #1
                beq  barrieron


barrieroff:     ldaa PTP
				oraa #%11011111
				cmpa #%11011111
				beq	 barrierset
				rts
				
barrieron:      ldaa PTP
				oraa #%11011111
				cmpa #%11011111
				beq	 barrierunset
				rts
				
barrierset:		ldaa PTP
                movb #1,barrier
                BSET PortS,#%10000000
                oraa #%11011111
				cmpa #%11011111
				beq	 barrierset
				rts
				
barrierunset:	ldaa PTP
                movb #0,barrier
                BCLR PortS,#%10000000
                oraa #%11011111
				cmpa #%11011111
				beq	 barrierunset
				rts
