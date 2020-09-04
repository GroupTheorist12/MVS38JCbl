       IDENTIFICATION DIVISION.                                           
       PROGRAM-ID.  'SEQSQL'.                                             
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
       01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
            88 EOF-SW         VALUE 'Y'.                               
            88 NOT-EOF-SW     VALUE 'N'.   
       01 IND-NO1          PIC 9(03).
       01 IND-NO2          PIC 9(03).
       01 IND-NO3          PIC 9(03).
       01 IND-NO4          PIC 9(03).
       01 IND-NO5          PIC 9(03).


       01 WS-CNT          PIC 9(1) VALUE 0.
       01 WS-FLDS         PIC 9(1) VALUE 5.                           
       PROCEDURE DIVISION.                                                
       MAIN-PART.                                                         
           OPEN INPUT SEQRDS-SYSIN.                                       
           PERFORM RDR-IT UNTIL EOF-SW.                                   
           CLOSE SEQRDS-SYSIN.                                            
           STOP RUN.                                                      
       RDR-IT.
            MOVE 1 TO WS-CNT.
            PERFORM  C-PARA.
            MOVE 2 TO WS-CNT.
            PERFORM  C-PARA.
            MOVE 3 TO WS-CNT.
            PERFORM  C-PARA.
            MOVE 4 TO WS-CNT.
            PERFORM  C-PARA.
            MOVE 5 TO WS-CNT.
            PERFORM  C-PARA.
            IF NOT-EOF-SW THEN
               PERFORM D-PARA.   

       C-PARA.
           IF NOT-EOF-SW THEN
             READ SEQRDS-SYSIN 
             AT END MOVE 'Y' TO WS-EOF-SW.
           IF NOT-EOF-SW THEN
             IF WS-CNT = 1 THEN 
                MOVE IDATA TO IND-NO1.    
             IF WS-CNT = 2 THEN 
                MOVE IDATA TO IND-NO2.    
             IF WS-CNT = 3 THEN 
                MOVE IDATA TO IND-NO3.    
             IF WS-CNT = 4 THEN 
                MOVE IDATA TO IND-NO4.    
             IF WS-CNT = 5 THEN 
                MOVE IDATA TO IND-NO5.    
                
       D-PARA.
           DISPLAY IND-NO1.
           DISPLAY IND-NO2.
           DISPLAY IND-NO3.
           DISPLAY IND-NO4.
           DISPLAY IND-NO5.
