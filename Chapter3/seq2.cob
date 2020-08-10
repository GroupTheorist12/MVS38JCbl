       IDENTIFICATION DIVISION.                                           
       PROGRAM-ID.  'SEQ1'.                                             
       ENVIRONMENT DIVISION.                                              
       CONFIGURATION SECTION.                                             
       SOURCE-COMPUTER.  IBM-360.                                         
       OBJECT-COMPUTER.  IBM-360.                                         
       INPUT-OUTPUT SECTION.                                              
       FILE-CONTROL.                                                      
           SELECT SEQRDS-SYSIN                                            
              ASSIGN TO UT-S-STUDENTS.                                    
           SELECT SEQRDS-SYSOUT                                            
              ASSIGN TO UT-S-STUDWRT.                                    
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

       FD  SEQRDS-SYSOUT                                                   
           RECORDING MODE IS F                                            
           RECORD CONTAINS 80 CHARACTERS                                  
           BLOCK  CONTAINS  0 RECORDS                                     
           LABEL RECORDS ARE OMITTED                                      
           DATA RECORD IS SEQRDS-SYSOUT-RECORD.                            
       01  SEQRDS-SYSOUT-RECORD.                                           
        05 STD-DATA        PIC X(80).                                                         

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

       01  WS-SYSOUT-RECORD.                                           
        02 STD-NO-OUT          PIC 9(03).                                                         
        02 STD-NAME-OUT        PIC X(20).                                                         
        02 STD-GENDER-OUT      PIC X(07).                                                         
        02 FILLER              PIC X(50) VALUE SPACES.                                                         
 
       PROCEDURE DIVISION.                                                
       MAIN-PART.                                                         
           OPEN INPUT SEQRDS-SYSIN.
           OPEN OUTPUT SEQRDS-SYSOUT.                                        
           PERFORM RDR-WRTR-IT UNTIL EOF-SW.                                   
           CLOSE SEQRDS-SYSIN 
           CLOSE SEQRDS-SYSOUT.
           STOP RUN.                                                      
       RDR-WRTR-IT.
            READ SEQRDS-SYSIN INTO WS-SYSIN-RECORD 
            AT END MOVE 'Y' TO WS-EOF-SW.
            IF NOT-EOF-SW 
               MOVE STD-NO-IN TO STD-NO-OUT
               MOVE STD-NAME-IN  TO STD-NAME-OUT
               MOVE STD-GENDER-IN  TO STD-GENDER-OUT
               DISPLAY 'CURRENT RECORD : ' WS-SYSOUT-RECORD
               WRITE SEQRDS-SYSOUT-RECORD FROM 
                 WS-SYSOUT-RECORD.     

      