       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'STRING2'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-STR1		PIC X(8) VALUE 'Ib7bbABC'.         
         01 WS-STR2		PIC X(6) VALUE 'b17ABC'.         
         01 WS-STR3		PIC X(6) VALUE 'CBA71b'.         

       PROCEDURE DIVISION.                                             
           DISPLAY 'TRANSFORM EXAMPLE....'.                   
           DISPLAY 'WS-STR1 BEFORE TRANSFORM: ' WS-STR1. 
           TRANSFORM WS-STR1 CHARACTERS FROM WS-STR2 TO WS-STR3.
           DISPLAY 'WS-STR1 AFTER TRANSFORM: ' WS-STR1. 
           STOP RUN. 
      * Ib7bbABC  b17ABC  CBA71b I BCACC71b                                                       
      *                            ICACC71b 