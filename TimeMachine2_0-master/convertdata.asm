               xdef ndata, convert

      
variables:  section
ndata:      ds.w  1

constants:  section
dummy:      dc.b  1
      
;assumes x points at string of inputs, b holds number of inputs  
;Converts string of numbers into a single number

convert:    ldy   #0
            sty   ndata
            cmpb  #4
            lbeq  thousands
            cmpb  #3
            lbeq  hundreds
            cmpb  #2
            lbeq  tens
            cmpb  #1
            lbeq  ones
            
     
thousands:  ldaa  #0           
            ldab  0,x
            ldy   #1000
            emul
            std   ndata
            inx
            
hundreds:   ldaa  #0           
            ldab  0,x
            ldy   #100
            emul
            addd  ndata
            std   ndata
            inx
            
tens:       ldaa  #0           
            ldab  0,x
            ldy   #10
            emul
            addd  ndata
            std   ndata
            inx
            
ones:       ldaa  #0           
            ldab  0,x
            addd  ndata
            std   ndata
            rts
