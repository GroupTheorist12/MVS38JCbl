       IDENTIFICATION DIVISION.                                           
       PROGRAM-ID.  'CURS2'.                                             
       ENVIRONMENT DIVISION.                                              
       CONFIGURATION SECTION.                                             
       SOURCE-COMPUTER.  IBM-360.                                         
       OBJECT-COMPUTER.  IBM-360.                                         
       INPUT-OUTPUT SECTION.                                              
       FILE-CONTROL.                                                      

           SELECT QUERY1-SYSIN
             ASSIGN TO 'CARS2.TXT'.
      *UT-S-QUERY1  
       DATA DIVISION.                                                     
       FILE SECTION.                                                      
       
       FD QUERY1-SYSIN
           RECORDING MODE IS F
           RECORD CONTAINS 80 CHARACTERS
           BLOCK  CONTAINS  0 RECORDS
           LABEL RECORDS ARE OMITTED
           DATA RECORD IS QUERY1-SYSIN-RECORD.
       01  QUERY1-SYSIN-RECORD.
       05 IDATA        PIC X(80).

       WORKING-STORAGE SECTION.                                           

       01 WS-CNT          PIC 9(1) VALUE 0.
       01 WS-FLDS         PIC 9(1) VALUE 5.
       01 SQLCODE         PIC 9(1) VALUE 0.
       01 WS-EOF-SW       PIC X(01) VALUE 'N'.
            88 EOF-SW         VALUE 'Y'.
            88 NOT-EOF-SW     VALUE 'N'.
       01  WS-CAR-MAKE             PIC X(30).
       01  WS-CAR-MODEL            PIC X(30).
       01  WS-CAR-PRODYR           PIC 9(04).

 
       PROCEDURE DIVISION.                                                
       MAIN-PART.                                                         

           OPEN INPUT QUERY1-SYSIN.

           PERFORM FETCH-LOOP UNTIL SQLCODE NOT EQUAL 0.

           CLOSE QUERY1-SYSIN.
       
           STOP RUN.
    
       FETCH-LOOP SECTION.
           IF NOT-EOF-SW THEN
             READ QUERY1-SYSIN
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO WS-CAR-MAKE.
           IF NOT-EOF-SW THEN
             READ QUERY1-SYSIN
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO WS-CAR-MODEL.
           IF NOT-EOF-SW THEN
             READ QUERY1-SYSIN
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO WS-CAR-PRODYR.
           IF EOF-SW THEN
             MOVE 1 TO SQLCODE.
           IF SQLCODE EQUAL 0
             DISPLAY 'MAKE ' WS-CAR-MAKE
             DISPLAY 'MODEL ' WS-CAR-MODEL
             DISPLAY 'FIRST YR PROD    '  WS-CAR-PRODYR.
                          
 
      
