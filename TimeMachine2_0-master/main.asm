 INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, lcdstring, keypress, loggeduser, PortU, PTP, usercount,PortS,mode,emergency,PTT,switchdif
            XDEF CRGFLG, PTS,

            XREF __SEG_END_SSTACK, init_LCD, read_pot, display_string, pot_value, strings, Keypad, userupdate, checknm
            XREF  checkpass, adjustpotval,potscale, optionmenu, barrier,powerbarrier, adduser,choice, waitrelease,Keypad2 
            XREF settimedif,port_tddr,ton,toff,tempon,tempoff,port_t,rti_isr, sturn, stpcnt, smflag, portP, portPddr, called
            XREF  tflag, setclock, tcount,SendsChr,PlayTone,speakvar,tablecount,eightnote,fifteennote,notecount, btflag, 
            XREF  setdest, diffset, tdflag,displaypot,travelmode, icount, dcount, f1, f2, f3, f4, fmax,dccount,supremecount
	    XREF  travelnote, pacount, interval, scopeflag
          

; variable/data section
my_variable: SECTION
lcdstring:	ds.b 33
keypress:   ds.b 1
loggeduser: ds.b 1
usercount:  ds.b  1
mode: ds.b 1
emergency: ds.b 1
switchdif:  ds.b 1

;constants section
my_constants: SECTION
PortU       equ $268
PortU_ddr:  equ $26A
PortU_psr:  equ $26D
PortU_pder: equ $26C
PortSddr:   equ $24a
PortS:      equ $248

; code section
MyCode:     SECTION
Entry:
_Startup:
            
                        
	;All this file really does is just start with the log in, then show the menu display and wait for the user to 
	;press F to select one, then calls the subroutine that corresponds. The labels and subroutine names make it clear
	;what each section of code covers.

            ;Inititalizations:        

            lds #__SEG_END_SSTACK               ;initializet the stack pointer
            jsr init_LCD                        ;initialize LCD
            BSET      PortU_ddr,#$f0            ;Initializes the keypad ports
            BSET      PortU_psr,#$f0
            BSET      PortU_pder,#$0f
            BSET      PortSddr,#$ff             ;Inititalizes the LEDs as output
            BSET      portPddr,#$1e
            movb   #$80,CRGINT                  ;enable real time interrupts
            movb   #$10,RTICTL                  ;get that 1ms delay
            movb  #5,usercount                  ;Initialize usercount and barrier and mode vars
            movb  #0,barrier
            movb  #0,mode
            movb  #0,emergency
            movb  #1,switchdif
            movb   #%00101000,port_tddr
            movb   #$08,port_t
            movb  #05,tempon
            movb  #10,tempoff
            movb  #05,ton
            movb  #10,toff
            movb   #0,stpcnt
            movb   #0,stpcnt+1
            movb   #0,tcount
            movb   #0,tcount+1
	    movb   #0,dccount
            movb   #0,dccount+1
            movb   #0,notecount
            movb   #0,notecount+1
            movb   #1,smflag
            movb   #1,speakvar
            movb   #0,fifteennote
	    movb   #0,travelnote
            movb   #0,eightnote  ;use in time travel engage
            movb   #1,PTS
            movb   #0,tdflag
            movb	#0, pacount
            movb	#0, pacount+1
            movb	#5, scopeflag
            movb	#0,interval
            ldaa   #0
	    ldx    #8192
            stx    supremecount
            staa    called
            staa    called+1
            staa    tflag
            staa    btflag
            staa    tdflag
	      staa	icount
            staa	dcount
            staa	f1
            staa	f2
            staa	f3
            staa	f4
            staa	fmax
            CLI
           
            ldaa  #1                  ;first time login and setup
            jsr userupdate
            jsr checknm
            jsr checkpass
            jsr waitrelease
            movb #0,keypress 
            movb  #1,fifteennote 
            ldaa  #4
            jsr strings
getrightpot:jsr displaypot
			jsr potscale
            ldaa keypress
            cmpa #15
            bne  getrightpot
            jsr waitrelease
            movb #0,keypress 
            lbra options              ;branch down to options
           
loggedout:  ldaa  #1
            jsr userupdate
            jsr checknm
            jsr checkpass
            movb #0,keypress 
            movb #0, emergency
            lbra options
            
options:    jsr  optionmenu          ;loop through when user is selecting an option
            ldd  #lcdstring
            jsr  display_string
            jsr  Keypad2
            ldaa keypress
            cmpa #15
            beq  enter
            jsr  powerbarrier
            ldaa emergency
			cmpa #2
			lbeq  freeze
            lbra  options 
            nop
           
           
enter:      ldaa  choice            ;load in choice made and branch to code needed
            cmpa #1
            lbeq  setclock1
            cmpa #2
            lbeq  traveldest
            cmpa #3
            lbeq  switchtimedif
            cmpa #4
            lbeq  addusers
            cmpa #5
            lbeq  logout
            cmpa #6
            lbeq  travel
           
setclock1:  movb #0,keypress
			jsr  setclock
			movb #0,keypress 
            lbra options
            
traveldest: movb #0,keypress 
            jsr  setdest
            movb #0,keypress
            lbra options
            
switchtimedif: movb #0,keypress
			   ldaa #9
			   movb   #$00,port_tddr
			   jsr strings
			   ldd #lcdstring
			   jsr display_string
               jsr  settimedif
	       jsr waitrelease
               movb #0,keypress  
               movb   #%00101000,port_tddr
               lbra options
            
addusers:   jsr adduser 
            movb #0,keypress 
            lbra options
           
travel:		movb #0,keypress
            ldaa barrier
		    cmpa #1
	     	lbne options
	     	movb #1,speakvar
	     	movb #0,fifteennote
	     	movb #1,eightnote
			movb #1,travelnote
			ldaa  #1
            staa  tflag
			ldaa #7
			ldab #0
			jsr strings
			ldd #lcdstring
			jsr diffset
			jsr display_string
			movb #1,tdflag
			jsr  travelmode  
			ldaa emergency
			cmpa #0
			bne  emergent
success:	jsr  Keypad2
            ldaa keypress
            cmpa #15
            bne  success
            jsr  waitrelease
            movb #0,keypress
            lbra options
emergent:	movb  #0,emergency            
logout:     movb #0,keypress 
            lbra loggedout
            
freeze: SEI
		movb #0,barrier
		ldaa PTS
		anda #%00111111
		staa PTS
		ldaa #8
		jsr strings
		ldd #lcdstring
		jsr display_string
push:   jsr  powerbarrier
		ldaa barrier
		cmpa #1
		bne push
		movb #0,emergency
		CLI
		lbra options
