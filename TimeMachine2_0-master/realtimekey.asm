            xdef userupdate
            xref display_string,strings,lcdstring
            
            
userupdate: ldaa #1
            jsr  strings  
            ldd  #lcdstring  
            jsr  display_string     ;display string
            rts