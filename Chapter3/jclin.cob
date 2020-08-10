       IDENTIFICATION DIVISION.                                           
       PROGRAM-ID.  'JCLIN'.                                             
       ENVIRONMENT DIVISION.                                              
       CONFIGURATION SECTION.                                            
       SOURCE-COMPUTER.  IBM-360.                                        
       OBJECT-COMPUTER.  IBM-360.                                        
       INPUT-OUTPUT SECTION.                                             
       FILE-CONTROL.                                                     
            SELECT SEQRDS-SYSIN                                           
              ASSIGN TO UT-S-SYSIN.                                      
       DATA DIVISION.                                                    
       FILE SECTION.                                                     
       FD  SEQRDS-SYSIN                                                  
           RECORDING MODE IS F                                           
           RECORD CONTAINS 80 CHARACTERS                                 
           BLOCK  CONTAINS  5 RECORDS                                    
           LABEL RECORDS ARE OMITTED                                     
           DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
       01  SEQRDS-SYSIN-RECORD.                                           
        02 STD-NO          PIC 9(03).                                                         
        02 STD-NAME        PIC X(20).                                                         
        02 STD-GENDER      PIC X(07).                                                         
        02 FILLER          PIC X(50).                                                         
       WORKING-STORAGE SECTION.  
        77 N PIC 99999999 COMP VALUE 5.                                    
        77 WS-FS           PIC 9(02).                                
       01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
            88 EOF-SW         VALUE 'Y'.                               
            88 NOT-EOF-SW     VALUE 'N'.                                

       01  WS-SYSIN-RECORD.                                           
        02 STD-NO-IN          PIC 9(03).                                                         
        02 STD-NAME-IN        PIC X(20).                                                         
        02 STD-GENDER-IN      PIC X(07).                                                         
        02 FILLER             PIC X(50).                  
       PROCEDURE DIVISION.         
       MAIN-PART.                                                         
           OPEN INPUT SEQRDS-SYSIN.
           PERFORM RDR-WRTR-IT UNTIL EOF-SW.                                   
           CLOSE SEQRDS-SYSIN 
           STOP RUN.                                                      
       RDR-WRTR-IT.
            READ SEQRDS-SYSIN INTO WS-SYSIN-RECORD 
            AT END MOVE 'Y' TO WS-EOF-SW.
            IF NOT-EOF-SW 
               DISPLAY 'CURRENT RECORD : ' WS-SYSIN-RECORD.
