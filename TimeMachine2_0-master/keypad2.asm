 xdef  Keypad2
    xref  keypress, 


My_Variables: SECTION
var:  ds.b  1
val:  ds.b  1
temp: ds.b  1

My_Constants: SECTION
PortU:      equ $268
PortU_ddr:  equ $26A
PortU_psr:  equ $26D
PortU_pder: equ $26C
PortS:      equ $248
PortSddr:   equ $24a
sequence:   dc.b  $70, $b0, $d0, $e0 
Lut:        dc.b $eb, $77, $7b, $7d, $b7, $bb, $bd, $d7, $db, $dd, $e7, $ed, $7e, $be, $de, $ee 






Keypad2: pshx
         pshy
         pshd
         BSET      PortU_ddr,#$f0            ;Initializes the keypad ports
         BSET      PortU_psr,#$f0
         BSET      PortU_pder,#$0f
     
        
        
        
        ;Loop for sending the sequence and checking for a button press
        
keyp:   ldx       #sequence     ;Sets x as index
        ldab      #1            ;sets b as counter
loop2:  cmpb      #5            ;Checks to see if too far
        beq       done
        ldaa      0,x
        inx
        incb                     
        staa      PortU         ;Sends sequence, checks for button press 
        jsr       DB
        ldaa      PortU
        staa      var
        anda      #%00001111    ;Looks to see if any was pressed
        cmpa      #$0f
        beq       loop2 
        lbra      match
        
        
        ;Loop for finding which button was pressed  
        
match:  ldx       #Lut          ;Sets index and counter for lookup table
        ldab      #1
loopm:  cmpb      #17           ;Checks to see if too far
        beq       match
        ldaa      0,x
        cmpa      var           ;Compares LUT value to value read in from keypad
        beq       found
        incb
        inx
        bra       loopm     
        
                               
found:  decb
        stab      keypress
        puld
        puly
        pulx
        rts   
        
done:   puld
        puly
        pulx
        rts 


        ;Debounce/Delay Subroutines
DB:     ldy       #10000
DB1:    dey
        bne       DB1
        rts
