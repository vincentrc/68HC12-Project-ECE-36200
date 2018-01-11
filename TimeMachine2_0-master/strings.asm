                          XDEF strings
                XREF lcdstring, keypress, dt1, dt2, dt3, dt4


;This file changes the string that is used for display on the lcd. The first value, passed through A, determines which section 
;to branch to, and the second, passed through B determines the subsection. This routine is called in multiple other files.

strings:   cmpa #0
           lbeq  logbasic
           cmpa #1
           lbeq  namelogin
           cmpa #2
           lbeq  passlogin
           cmpa #3
           lbeq  optionbasic
           cmpa #4
           lbeq  setpotscale
           cmpa #5
           lbeq  newuser
           cmpa #6
           lbeq  clckst
           cmpa #7
           lbeq  tdisp
           cmpa #8
           lbeq  emergence
           cmpa #9
           lbeq  setdiff
           
namelogin: cmpb   #1
           lbeq   logname1
           cmpb   #2
           lbeq   logname2
           cmpb   #3
           lbeq   logname3
           cmpb   #4
           lbeq   logname4
           cmpb   #5
           lbeq   logname5
           cmpb   #6
           lbeq   logname6
           cmpb   #7
           lbeq   logname7
           cmpb   #8
           lbeq   logname8          
                  
           
logbasic:  movb #'u',lcdstring
           movb #'s',lcdstring+1
           movb #'e',lcdstring+2
           movb #'r',lcdstring+3
           movb #'n',lcdstring+4
           movb #'a',lcdstring+5
           movb #'m',lcdstring+6
           movb #'e',lcdstring+7
           movb #':',lcdstring+8
           movb #' ',lcdstring+9
           movb #' ',lcdstring+10
           movb #' ',lcdstring+11
           movb #' ',lcdstring+12
           movb #' ',lcdstring+13
           movb #' ',lcdstring+14
           movb #' ',lcdstring+15
           movb #'p',lcdstring+16
           movb #'a',lcdstring+17
           movb #'s',lcdstring+18
           movb #'s',lcdstring+19
           movb #'w',lcdstring+20
           movb #'o',lcdstring+21
           movb #'r',lcdstring+22
           movb #'d',lcdstring+23
           movb #':',lcdstring+24
           movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
 optionbasic: cmpb #0
           		lbeq option0
 				      cmpb #1
           		lbeq option1
           		cmpb #2
           		lbeq  option2
           		cmpb #3
              lbeq  option3
        	    cmpb #4
           	  lbeq  option4
         	    cmpb #5
              lbeq  option5
              cmpb #6
              lbeq  option6
               
option1:   movb #'S',lcdstring+17
           movb #'e',lcdstring+18
           movb #'t',lcdstring+19
           movb #' ',lcdstring+20
           movb #'C',lcdstring+21
           movb #'l',lcdstring+22
           movb #'o',lcdstring+23
           movb #'c',lcdstring+24
           movb #'k',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
               
option2:   movb #'T',lcdstring+17
           movb #'r',lcdstring+18
           movb #'a',lcdstring+19
           movb #'v',lcdstring+20
           movb #'e',lcdstring+21
           movb #'l',lcdstring+22
           movb #' ',lcdstring+23
           movb #'D',lcdstring+24
           movb #'e',lcdstring+25
           movb #'s',lcdstring+26
           movb #'t',lcdstring+27
           movb #'i',lcdstring+28
           movb #'n',lcdstring+29
           movb #'y',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
               
option3:   movb #'S',lcdstring+17
           movb #'e',lcdstring+18
           movb #'t',lcdstring+19
           movb #' ',lcdstring+20
           movb #'T',lcdstring+21
           movb #'i',lcdstring+22
           movb #'m',lcdstring+23
           movb #'e',lcdstring+24
           movb #' ',lcdstring+25
           movb #'D',lcdstring+26
           movb #'i',lcdstring+27
           movb #'f',lcdstring+28
           movb #'f',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
               
option4:   movb #'A',lcdstring+17
           movb #'d',lcdstring+18
           movb #'d',lcdstring+19
           movb #' ',lcdstring+20
           movb #'U',lcdstring+21
           movb #'s',lcdstring+22
           movb #'e',lcdstring+23
           movb #'r',lcdstring+24
           movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
               
option5:   movb #'L',lcdstring+17
           movb #'O',lcdstring+18
           movb #'G',lcdstring+19
           movb #'O',lcdstring+20
           movb #'U',lcdstring+21
           movb #'T',lcdstring+22
           movb #' ',lcdstring+23
           movb #' ',lcdstring+24
           movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
emergence: movb #'E',lcdstring
           movb #'M',lcdstring+1
           movb #'E',lcdstring+2
           movb #'R',lcdstring+3
           movb #'G',lcdstring+4
           movb #'E',lcdstring+5
           movb #'N',lcdstring+6
           movb #'C',lcdstring+7
           movb #'Y',lcdstring+8
           movb #'!',lcdstring+9
           movb #' ',lcdstring+10
           movb #'P',lcdstring+11
           movb #'O',lcdstring+12
           movb #'W',lcdstring+13
           movb #'E',lcdstring+14
           movb #'R',lcdstring+15
           movb #'T',lcdstring+16
           movb #'H',lcdstring+17
           movb #'E',lcdstring+18
           movb #' ',lcdstring+19
           movb #'B',lcdstring+20
           movb #'A',lcdstring+21
           movb #'R',lcdstring+22
           movb #'R',lcdstring+23
           movb #'I',lcdstring+24
           movb #'E',lcdstring+25
           movb #'R',lcdstring+26
           movb #' ',lcdstring+27
           movb #'N',lcdstring+28
           movb #'O',lcdstring+29
           movb #'W',lcdstring+30
           movb #'!',lcdstring+31
           movb #0,lcdstring+32  
           rts
setdiff:   movb #'M',lcdstring
           movb #'O',lcdstring+1
           movb #'D',lcdstring+2
           movb #'I',lcdstring+3
           movb #'F',lcdstring+4
           movb #'Y',lcdstring+5
           movb #' ',lcdstring+6
           movb #'S',lcdstring+7
           movb #'W',lcdstring+8
           movb #'I',lcdstring+9
           movb #'T',lcdstring+10
           movb #'C',lcdstring+11
           movb #'H',lcdstring+12
           movb #'E',lcdstring+13
           movb #'S',lcdstring+14
           movb #'!',lcdstring+15
           movb #' ',lcdstring+16
           movb #'S',lcdstring+17
           movb #'C',lcdstring+18
           movb #'A',lcdstring+19
           movb #'L',lcdstring+20
           movb #'E',lcdstring+21
           
           cmpb   #1
           lbeq   s
           cmpb   #2
           lbeq   m
           cmpb   #3
           lbeq   h
           cmpb   #4
           lbeq   da
           cmpb   #5
           lbeq   mo
           cmpb   #6
           lbeq   yr
           rts
           
s:         movb #':',lcdstring+22
           movb #'S',lcdstring+23
           movb #'E',lcdstring+24
           movb #'C',lcdstring+25
           movb #'O',lcdstring+26
           movb #'N',lcdstring+27
           movb #'D',lcdstring+28
           movb #'S',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts
m:         movb #':',lcdstring+22
           movb #'M',lcdstring+23
           movb #'I',lcdstring+24
           movb #'N',lcdstring+25
           movb #'U',lcdstring+26
           movb #'T',lcdstring+27
           movb #'E',lcdstring+28
           movb #'S',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
h:         movb #':',lcdstring+22
           movb #'H',lcdstring+23
           movb #'O',lcdstring+24
           movb #'U',lcdstring+25
           movb #'R',lcdstring+26
           movb #'S',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
da:        movb #':',lcdstring+22
           movb #'D',lcdstring+23
           movb #'A',lcdstring+24
           movb #'Y',lcdstring+25
           movb #'S',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
mo:         movb #':',lcdstring+22
           movb #'M',lcdstring+23
           movb #'O',lcdstring+24
           movb #'N',lcdstring+25
           movb #'T',lcdstring+26
           movb #'H',lcdstring+27
           movb #'S',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
yr:         movb #':',lcdstring+22
           movb #'Y',lcdstring+23
           movb #'E',lcdstring+24
           movb #'A',lcdstring+25
           movb #'R',lcdstring+26
           movb #'S',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #'F',lcdstring+31
           movb #0,lcdstring+32  
           rts

           
option6:   movb #'T',lcdstring+17
           movb #'R',lcdstring+18
           movb #'A',lcdstring+19
           movb #'V',lcdstring+20
           movb #'E',lcdstring+21
           movb #'L',lcdstring+22
           movb #' ',lcdstring+23
           movb #' ',lcdstring+24
           movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
option0:   movb #'O',lcdstring
           movb #'p',lcdstring+1
           movb #'t',lcdstring+2
           movb #'i',lcdstring+3
           movb #'o',lcdstring+4
           movb #'n',lcdstring+5
           movb #'-',lcdstring+6
           movb #'>',lcdstring+7
           movb #' ',lcdstring+8
           movb #' ',lcdstring+9
           movb #' ',lcdstring+10
           movb #' ',lcdstring+11
           movb #' ',lcdstring+12
           movb #' ',lcdstring+13
           movb #' ',lcdstring+14
           movb #' ',lcdstring+15
           movb #'>',lcdstring+16
           movb #' ',lcdstring+17
           movb #' ',lcdstring+18
           movb #' ',lcdstring+19
           movb #' ',lcdstring+20
           movb #' ',lcdstring+21
           movb #' ',lcdstring+22
           movb #' ',lcdstring+23
           movb #' ',lcdstring+24
           movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
setpotscale:movb #'T',lcdstring
           movb #'u',lcdstring+1
           movb #'r',lcdstring+2
           movb #'n',lcdstring+3
           movb #' ',lcdstring+4
           movb #'p',lcdstring+5
           movb #'o',lcdstring+6
           movb #'t',lcdstring+7
           movb #' ',lcdstring+8
           movb #'t',lcdstring+9
           movb #'o',lcdstring+10
           movb #' ',lcdstring+11
           movb #'m',lcdstring+12
           movb #'a',lcdstring+13
           movb #'x',lcdstring+14
           movb #'!',lcdstring+15
           movb #'#',lcdstring+16
           movb #' ',lcdstring+17
           movb #' ',lcdstring+18
           movb #' ',lcdstring+19
           movb #' ',lcdstring+20
           movb #' ',lcdstring+21
           movb #' ',lcdstring+22
           movb #' ',lcdstring+23
           movb #'P',lcdstring+24
           movb #'r',lcdstring+25
           movb #'e',lcdstring+26
           movb #'s',lcdstring+27
           movb #'s',lcdstring+28
           movb #' ',lcdstring+29
           movb #'F',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
 
 logname1: movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'1',lcdstring+13 
           rts
           
logname2:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'2',lcdstring+13
           rts
           
logname3:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'3',lcdstring+13
           rts
           
logname4:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'4',lcdstring+13
           rts
           
logname5:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'5',lcdstring+13
           rts
           
logname6:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'6',lcdstring+13
           rts


logname7:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'7',lcdstring+13
           rts


logname8:  movb #'n',lcdstring+9
           movb #'a',lcdstring+10
           movb #'m',lcdstring+11
           movb #'e',lcdstring+12
           movb #'8',lcdstring+13
           rts


           
passlogin: cmpb #0
           lbeq logpass0
           cmpb #1
           lbeq logpass1
           cmpb #2
           lbeq  logpass2
           cmpb #3
           lbeq  logpass3
           cmpb #4
           lbeq  logpass4
           cmpb #5
           lbeq  logpass5
           cmpb #6
           lbeq  logpass6
           cmpb #7
           lbeq  logpass7
           
logpass0:  movb #' ',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts

logpass1:  movb #'*',lcdstring+25
           movb #' ',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
           
logpass2:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #' ',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts

logpass3:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #'*',lcdstring+27
           movb #' ',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts

logpass4:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #'*',lcdstring+27
           movb #'*',lcdstring+28
           movb #' ',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts

logpass5:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #'*',lcdstring+27
           movb #'*',lcdstring+28
           movb #'*',lcdstring+29
           movb #' ',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts
                      
logpass6:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #'*',lcdstring+27
           movb #'*',lcdstring+28
           movb #'*',lcdstring+29
           movb #'*',lcdstring+30
           movb #' ',lcdstring+31
           movb #0,lcdstring+32  
           rts

logpass7:  movb #'*',lcdstring+25
           movb #'*',lcdstring+26
           movb #'*',lcdstring+27
           movb #'*',lcdstring+28
           movb #'*',lcdstring+29
           movb #'*',lcdstring+30
           movb #'*',lcdstring+31
           movb #0,lcdstring+32  
           rts    
           
           
newuser:  cmpb  #0
          lbeq   startup
          cmpb  #1
          lbeq  nu1
          cmpb  #2
          lbeq  nu2
          cmpb  #3
          lbeq  nu3
          cmpb  #4
          lbeq  nu4
          cmpb  #5
          lbeq  nufull
          rts 
           
           
startup:  movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'N',lcdstring+6
          movb #'e',lcdstring+7
          movb #'w',lcdstring+8
          movb #' ',lcdstring+9
          movb #'P',lcdstring+10
          movb #'i',lcdstring+11
          movb #'n',lcdstring+12
          movb #':',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts  
          
nu1:      ldaa  keypress
          adda  #$30
          staa  lcdstring+16  
          rts

nu2:      ldaa  keypress
          adda  #$30
          staa  lcdstring+17 
          rts

nu3:       ldaa  keypress
          adda  #$30
          staa  lcdstring+18 
          rts

nu4:       ldaa  keypress
          adda  #$30
          staa  lcdstring+19 
          rts

nufull:   movb #'F',lcdstring
          movb #'U',lcdstring+1
          movb #'L',lcdstring+2
          movb #'L',lcdstring+3
          movb #'!',lcdstring+4
          movb #'!',lcdstring+5
          movb #' ',lcdstring+6
          movb #' ',lcdstring+7
          movb #' ',lcdstring+8
          movb #' ',lcdstring+9
          movb #' ',lcdstring+10
          movb #' ',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
          
clckst:     cmpb  #0
            lbeq  css
            cmpb  #1
            lbeq  csm
            cmpb  #2
            lbeq  csh
            cmpb  #3
            lbeq  csmo
            cmpb  #4
            lbeq  csd
            cmpb  #5
            lbeq  csy
            
            
css:      movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'S',lcdstring+6
          movb #'e',lcdstring+7
          movb #'c',lcdstring+8
          movb #'o',lcdstring+9
          movb #'n',lcdstring+10
          movb #'d',lcdstring+11
          movb #'s',lcdstring+12
          movb #':',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
    
csm:      movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'M',lcdstring+6
          movb #'i',lcdstring+7
          movb #'n',lcdstring+8
          movb #'u',lcdstring+9
          movb #'t',lcdstring+10
          movb #'e',lcdstring+11
          movb #'s',lcdstring+12
          movb #':',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
          
csh:      movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'H',lcdstring+6
          movb #'o',lcdstring+7
          movb #'u',lcdstring+8
          movb #'r',lcdstring+9
          movb #'s',lcdstring+10
          movb #':',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
          
csmo:     movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'M',lcdstring+6
          movb #'o',lcdstring+7
          movb #'n',lcdstring+8
          movb #'t',lcdstring+9
          movb #'h',lcdstring+10
          movb #':',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts  
          
          
csd:      movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'D',lcdstring+6
          movb #'a',lcdstring+7
          movb #'y',lcdstring+8
          movb #':',lcdstring+9
          movb #' ',lcdstring+10
          movb #' ',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
          
csy:      movb #'E',lcdstring
          movb #'n',lcdstring+1
          movb #'t',lcdstring+2
          movb #'e',lcdstring+3
          movb #'r',lcdstring+4
          movb #' ',lcdstring+5
          movb #'Y',lcdstring+6
          movb #'e',lcdstring+7
          movb #'a',lcdstring+8
          movb #'r',lcdstring+9
          movb #':',lcdstring+10
          movb #' ',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #' ',lcdstring+16
          movb #' ',lcdstring+17
          movb #' ',lcdstring+18
          movb #' ',lcdstring+19
          movb #' ',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #' ',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #' ',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
          
tdisp:    cmpb  #0
          lbeq  td1
          cmpb  #1
          lbeq  ts
          cmpb  #2
          lbeq  tm
          cmpb  #3
          lbeq  th
          cmpb  #4
          lbeq  tmo
          cmpb  #5
          lbeq  tda
          cmpb  #6
          lbeq  ty
          
td1:      movb #'T',lcdstring
          movb #'i',lcdstring+1
          movb #'m',lcdstring+2
          movb #'e',lcdstring+3
          movb #':',lcdstring+4
          movb #' ',lcdstring+5
          movb #' ',lcdstring+6
          movb #' ',lcdstring+7
          movb #':',lcdstring+8
          movb #' ',lcdstring+9
          movb #' ',lcdstring+10
          movb #':',lcdstring+11
          movb #' ',lcdstring+12
          movb #' ',lcdstring+13
          movb #' ',lcdstring+14
          movb #' ',lcdstring+15
          movb #'D',lcdstring+16
          movb #'a',lcdstring+17
          movb #'t',lcdstring+18
          movb #'e',lcdstring+19
          movb #':',lcdstring+20
          movb #' ',lcdstring+21
          movb #' ',lcdstring+22
          movb #' ',lcdstring+23
          movb #'/',lcdstring+24
          movb #' ',lcdstring+25
          movb #' ',lcdstring+26
          movb #'/',lcdstring+27
          movb #' ',lcdstring+28
          movb #' ',lcdstring+29
          movb #' ',lcdstring+30
          movb #' ',lcdstring+31
          movb #0,lcdstring+32  
          rts
          
ts:       ldaa  dt1
          adda  #$30
          staa  lcdstring+12
          ldaa  dt2
          adda  #$30
          staa  lcdstring+13
          rts
          
tm:       ldaa  dt1
          adda  #$30
          staa  lcdstring+9
          ldaa  dt2
          adda  #$30
          staa  lcdstring+10
          rts
          
th:       ldaa  dt1
          adda  #$30
          staa  lcdstring+6
          ldaa  dt2
          adda  #$30
          staa  lcdstring+7
          rts
          
tmo:      ldaa  dt1
          adda  #$30
          staa  lcdstring+22
          ldaa  dt2
          adda  #$30
          staa  lcdstring+23
          rts
          
tda:      ldaa  dt1
          adda  #$30
          staa  lcdstring+25
          ldaa  dt2
          adda  #$30
          staa  lcdstring+26
          rts
          
ty:       ldaa  dt1
          adda  #$30
          staa  lcdstring+28
          ldaa  dt2
          adda  #$30
          staa  lcdstring+29
          ldaa  dt3
          adda  #$30
          staa  lcdstring+30
          ldaa  dt4
          adda  #$30
          staa  lcdstring+31
          rts
         
