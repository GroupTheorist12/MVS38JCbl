       IDENTIFICATION DIVISION.                                           
       PROGRAM-ID.  'SEQSQL3'.                                             
       ENVIRONMENT DIVISION.                                              
       CONFIGURATION SECTION.                                             
       SOURCE-COMPUTER.  IBM-360.                                         
       OBJECT-COMPUTER.  IBM-360.                                         
       INPUT-OUTPUT SECTION.                                              
       FILE-CONTROL.                                                      
           SELECT SEQRDS-SYSIN                                            
              ASSIGN TO 'DUMMY.DAT'.                                    
       DATA DIVISION.                                                     
       FILE SECTION.                                                      
       FD  SEQRDS-SYSIN                                                   
           RECORDING MODE IS F                                            
           RECORD CONTAINS 80 CHARACTERS                                  
           BLOCK  CONTAINS  0 RECORDS                                     
           LABEL RECORDS ARE OMITTED                                      
           DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
       01  SEQRDS-SYSIN-RECORD.                                           
         02 IDATA           PIC X(80). 
       WORKING-STORAGE SECTION.                                           
       77 N PIC 99999999 COMP VALUE 5.                                    
       77 WS-FS           PIC 9(02). 
       01 SQLCODE         PIC 9 VALUE 0.                               
       01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
            88 EOF-SW         VALUE 'Y'.                               
            88 NOT-EOF-SW     VALUE 'N'.   
       01 IND-NO1          PIC 9(03).
       01 IND-NO2          PIC 9(03).
       01 IND-NO3          PIC 9(03).
       01 IND-NO4          PIC 9(03).
       01 IND-NO5          PIC 9(03).

       PROCEDURE DIVISION.                                                
       MAIN-PART.                                                         
           OPEN INPUT SEQRDS-SYSIN.                                       
           PERFORM FETCH-LOOP UNTIL SQLCODE NOT EQUAL 0.                                   
           CLOSE SEQRDS-SYSIN.                                            
           STOP RUN.                                                      
       FETCH-LOOP SECTION.
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO IND-NO1.    
           
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO IND-NO2.    
           
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO IND-NO3.    
           
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO IND-NO4.    
           
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             MOVE IDATA TO IND-NO5.    
           
           IF EOF-SW THEN
              MOVE 1 TO SQLCODE.

           IF SQLCODE EQUAL 0 THEN    
             DISPLAY IND-NO1
             DISPLAY IND-NO2
             DISPLAY IND-NO3
             DISPLAY IND-NO4
             DISPLAY IND-NO5.

