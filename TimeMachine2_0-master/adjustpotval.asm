        xdef adjustpotval
        xref pot_value,ones,tenths,hundredths
        
variable: SECTION
temp:   ds.w     1


constants:  section
table:      dc.b  1 ;not sure why but variables don't work without this constant section
        
;This file normalizes the potentiometer value       
        
adjustpotval: pshx
              pshy
              pshd
              ldd pot_value
              ldaa ones
              mul               ;multiply pot_value by ones value
              std  temp
              ldd pot_value
              ldx  #10
              idiv 
              xgdx
              ldaa tenths
              mul   
              addd temp
              ldd pot_value
              ldx  #100
              idiv 
              xgdx
              ldaa hundredths
              mul   
              addd temp 
              std pot_value  
              puld
              puly
              pulx
              rts
