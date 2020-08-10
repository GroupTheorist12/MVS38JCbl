       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'RAND1'.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT SEQRDS-SYSIN                                            
              ASSIGN TO UT-S-STUDENTS                                    
              ORGANIZATION IS INDEXED
              ACCESS IS RANDOM
              RECORD KEY IS STD-NO.
       DATA DIVISION.                                                     
       FILE SECTION.                                                      
       FD  SEQRDS-SYSIN                                                   
           RECORDING MODE IS F                                            
           RECORD CONTAINS 80 CHARACTERS                                  
           BLOCK  CONTAINS  0 RECORDS                                     
           LABEL RECORDS ARE OMITTED                                      
           DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
       01  SEQRDS-SYSIN-RECORD.                                           
        02 STD-NO          PIC 9(03).                                                         
        02 STD-NAME        PIC X(20).                                                         
        02 STD-GENDER      PIC X(07).                                                         
        02 FILLER          PIC X(50).                                                         


       WORKING-STORAGE SECTION.
       01  WS-SYSIN-RECORD.                                           
        02 STD-NO-IN          PIC 9(03).                                                         
        02 STD-NAME-IN        PIC X(20).                                                         
        02 STD-GENDER-IN      PIC X(07).                                                         
        02 FILLER             PIC X(50).                                                         

       PROCEDURE DIVISION.
           OPEN INPUT SEQRDS-SYSIN.
           MOVE 103 TO STD-NO.
      
            READ SEQRDS-SYSIN RECORD INTO WS-SYSIN-RECORD
              KEY IS STD-NO
              INVALID KEY DISPLAY 'Invalid Key'
              NOT INVALID KEY DISPLAY WS-SYSIN-RECORD.
      
            CLOSE SEQRDS-SYSIN.
            STOP RUN.