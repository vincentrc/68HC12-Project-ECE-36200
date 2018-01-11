  xdef  waitrelease
  xref  PortU

;This just waits until no keys are pressed
waitrelease:  psha
loop:         ldaa  PortU
              anda  #$0f
              cmpa  #$0f
              bne   loop
              pula
              rts
