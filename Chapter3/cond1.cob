       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'COND1'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-NUM1 PIC 9(9).
         01 WS-NUM2 PIC 9(9).

       PROCEDURE DIVISION.
       00-MAIN.
           MOVE 25 TO WS-NUM1.
           MOVE 15 TO WS-NUM2.
           IF WS-NUM1 > WS-NUM2 THEN
              DISPLAY 'WS-NUM1 > WS-NUM2'
           ELSE
              DISPLAY 'WS-NUM2 > WS-NUM1'.
      *    ENDIF        
           STOP RUN.