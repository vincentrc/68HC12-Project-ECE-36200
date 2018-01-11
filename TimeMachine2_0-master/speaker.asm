                xdef speaker,welcome,speakvar,tablecount,eightnote,fifteennote,travelnote
        xref SendsChr
        
 
variables:  section
speakvar:  ds.b  1
tablecount:  ds.w 1
eightnote:   ds.b  1
fifteennote: ds.b  1
travelnote:  ds.b  1
tableholder: ds.w 1


constants:  section
A3:    equ   37
B3:    equ   33
C3:    equ   63
D3:    equ   56
E3:    equ   50
F3:    equ   47
G3:    equ   42
A4:    equ   19
B4:    equ   17
C4:    equ   31
D4:    equ   28
E4:    equ   25
F4:    equ   23
G4:    equ   21
Ab3:   equ   39
Bb3:   equ   35
Db3:   equ   59
Eb3:   equ   53
Gb3:   equ   44
Ab4:   equ   20
Bb4:   equ   18
Db4:   equ   30
Eb4:   equ   26
Gb4:   equ   22
A5:    equ   9;D4;9
B5:    equ   8;F4;8
C5:    equ   16;G4;16
D5:    equ   14;G4;14
E5:    equ   12;A5;12
F5:    equ   12;A5;12
G5:    equ   10;A5;10
Ab5:   equ   10;Db4;10
Bb5:   equ   9;Eb4;9
Db5:   equ   15;G5;15
Eb5:   equ   13;G5;13
Gb5:   equ   11;G5;11
PA:    equ   255

;This is the welcome song, behold:

;It uses the notes as defined above, and then sends to the C function until done.
;This file includes all of the songs (welcome and travel jingle), and plays them when
;called at the appropriate time. (Called in RTI for correct timing).


welcome:   dc.b C4,C4,C4,C4,D4,D4,D4,D4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4
           dc.b Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,F4,F4,F4,F4
           dc.b G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4 
           dc.b Bb5,Bb5,Bb5,Bb5,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,Ab5,Ab5
           dc.b F4,F4,Eb4,Eb4,Eb4,Eb4,D4,D4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4
           dc.b C4,C4,C4,C4,C4,C4,C4,C4,Ab5,Ab5,Ab5,Ab5,G4,G4,G4,G4,Eb4,Eb4,Eb4,Eb4
           dc.b Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4
           dc.b F5,F5,F5,F5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5,G5
           dc.b G5,G5,G5,G5,Bb5,Bb5,Bb5,Bb5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5
           dc.b C5,C5,C5,C5,Bb5,Bb5,Bb5,Bb5,Bb5,Bb5,D5,D5,D5,D5,C5,C5,C5,C5
           dc.b C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C4,C4,C4,C4,C4,C4,D4,D4,D4,D4 ;3rd line starts
           dc.b Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,D4,D4,D4,D4,D4,D4,D4,D4,C4,C4,C4,C4
           dc.b C4,C4,C4,C4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4,Ab4,Ab4,Ab4,Ab4,Ab4,Ab4,Ab4,Ab4
           dc.b G3,G3,G3,G3,G3,G3,G3,G3,F3,F3,F3,F3,F3,F3,F3,F3 ,F3,F3,F3,F3,F3,F3,F3,F3
           dc.b Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,G3,G3,G3,G3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3
           dc.b G3,G3,F3,F3,E3,E3,E3,E3,D3,D3,D3,D3,C3,C3,C3,C3,C3,C3,C3,C3
           dc.b Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3 ;4th line
           dc.b D3,D3,D3,D3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3,E3
           dc.b E3,E3,E3,E3,F3,F3,F3,F3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3
           dc.b G3,G3,G3,G3,B4,B4,B4,B4,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3
           dc.b G3,G3,F3,F3,E3,E3,E3,E3,D3,D3,D3,D3,C3,C3,C3,C3,C3,C3,C3,C3
           dc.b Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,C3,C3,C3,C3,D3,D3,D3,D3,Eb3,Eb3,Eb3,Eb3   ;5th line
           dc.b Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,Eb3,F3,F3,F3,F3,F3
           dc.b G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3,G3
           dc.b B4,B4,B4,B4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4
           dc.b B4,B4,B4,B4,B4,B4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4     ;almostsecondpage
           dc.b C4,C4,C4,C4,C4,PA,C4,C4,C4,C4,C4,C4,D4,D4,D4,D4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4
           dc.b D4,D4,D4,D4,D4,D4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4,Bb4
           dc.b Ab4,Ab4,Ab4,Ab4,Ab4,Ab4,Ab4,Ab4,G3,G3,G3,G3,G3,G3,G3,G3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3
           dc.b F3,F3,F3,F3,E3,E3,E3,E3,E3,E3,G3,G3,G3,G3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3,F3
           dc.b G3,G3,F3,F3,E3,E3,E3,E3,D3,D3,D3,D3,C3,C3,C3,C3,C3,C3,C3,C3,Ab3,Ab3 ;top line second page
           dc.b Ab3,Ab3,Ab3,Ab3,Ab3,Ab3,C3,C3,C3,C3,C3,C3,C3,C3,A4,A4,A4,A4,A4,A4,A4,A4
           dc.b C4,C4,C4,C4,D4,D4,D4,D4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4
           dc.b PA,Eb4,Eb4,Eb4,Eb4,F4,F4,F4,F4,G4,G4,G4,G4,G4,G4,G4,G4,G3,G3
           dc.b G3,G3,G3,G3,G3,G3,G4,G4,G4,G4,B5,B5,B5,B5,F4,F4,F4,F4,F4,F4
           dc.b G4,G4,F4,F4,Eb4,Eb4,Eb4,Eb4,D4,D4,D4,D4,F4,F4,F4,F4,A5,A5,A5,A5
           dc.b C4,C4,C4,C4,D4,D4,D4,D4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4
           dc.b Eb4,Eb4,Eb4,Eb4,F4,F4,F4,F4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4,G4
           dc.b PA,G4,G4,G4,G4,Bb5,Bb5,Bb5,Bb5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5,C5
           dc.b B4,B4,B4,B4,D4,D4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4
           dc.b PA,C4,C4,C4,C4,D4,D4,D4,D4,G4,G4,G4,G4,F4,F4,F4,F4,Eb4,Eb4,Eb4,Eb4
           dc.b PA,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,Eb4,D4,D4,D4,D4,D4,D4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4
           dc.b F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,Eb4,Eb4,Eb4,Eb4
           dc.b G4,G4,G4,G4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,F4,G4,G4,F4,F4,Eb4,Eb4
           dc.b Eb4,Eb4,D4,D4,D4,D4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4,C4
           dc.b Eb3,Eb3,Eb3,Eb3,D3,D3,D3,D3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3
           dc.b Eb3,Eb3,Eb3,Eb3,D3,D3,D3,D3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3,C3
	       dc.b C3,C3,C3,C3,C3,C3,C3,C3,0
           
           
travel:    dc.b  Eb4,Eb4,C4,C4,Eb4,Eb4,B4,B4,B4,B4,D4,D4,G4,G4,C4,C4,E4,E4,E4,E4,G4,G4,G4,G4
           dc.b  F4,F4,E4,E4,F4,F4,A5,A5,A5,A5,A5,A5,0
           
timetravel:  dc.b  D4,D4,D4,F4,F4,F4,0


speaker: ldaa fifteennote
         cmpa #1
         bne  eight
         ldaa speakvar
         cmpa #0
         beq  loaded
         movb #0,speakvar
         movb #0,tablecount
         movb #0,tablecount+1
         ldy  #welcome   ;load in Data Address
         sty  tableholder
         bra  loaded
         
eight: ldaa eightnote
       cmpa #1
       bne  travelin
       ldaa speakvar
       cmpa #0
       beq  loaded
       movb #0,speakvar
       movb #0,tablecount 
       movb #0,tablecount+1
       ldy  #travel   ;load in Data Address
       sty  tableholder
       bra  loaded
           
travelin:ldaa travelnote
       cmpa #1
       bne  ending
	   ldaa speakvar
       cmpa #0
       beq  loaded
       movb #0,speakvar
       movb #0,tablecount 
       movb #0,tablecount+1
       ldy  #timetravel     ;load in Data Address
       sty  tableholder	



loaded:  ldd  tableholder
         addd tablecount
         tfr  d,y    
         ldd tablecount
         addd #1
         std tablecount
         ldaa y
         cmpa #0
         bne  notend
         movb #1,speakvar
         movb #0,fifteennote
         movb #0,eightnote
         
notend:  psha             ;put char on stack
         jsr  SendsChr   ;use CALL command
         pula 
ending:  rts
