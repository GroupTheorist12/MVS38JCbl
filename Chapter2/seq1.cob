   10 * //////////////////////////////////////////////////////////        
   20 * // Name: Brad Rigg                                                
   30 * // Program: Read Seq File                                         
   40 * // Due: Never                                                     
   50 * // Language: COBOL                                                
   60 * //                                                                
   70 * // Changes:                                                       
   80 * // - Brad Rigg 2020/07/08                                         
   90 * //                                                                
  100 * //                                                                
  110 * //                                                                
  120 * //                                                                
  130 * //                                                                
  140 * //////////////////////////////////////////////////////////        
  150 ***                                                                 
  160 ***                                                                 
  170 ***                                                                 
  180  IDENTIFICATION DIVISION.                                           
  190  PROGRAM-ID.  'SEQ1'.                                             
  200 ***CALL 'ILBOWAT0' USING DELAY-AMT. delay stuff                     
  210 ***                                                                 
  220 ***                                                                 
  230  ENVIRONMENT DIVISION.                                              
  240 **                                                                  
  250 **                                                                  
  260  CONFIGURATION SECTION.                                             
  270  SOURCE-COMPUTER.  IBM-360.                                         
  280  OBJECT-COMPUTER.  IBM-360.                                         
  290 **                                                                  
  300 **                                                                  
  310  INPUT-OUTPUT SECTION.                                              
  320  FILE-CONTROL.                                                      
  330      SELECT SEQRDS-SYSIN                                            
  340         ASSIGN TO UT-S-STUDENTS.                                    
  350 ***                                                                 
  360 ***                                                                 
  370 ***                                                                 
  380  DATA DIVISION.                                                     
  390 **                                                                  
  400 **                                                                  
  410  FILE SECTION.                                                      
  420  FD  SEQRDS-SYSIN                                                   
  430      RECORDING MODE IS F                                            
  440      RECORD CONTAINS 80 CHARACTERS                                  
  450      BLOCK  CONTAINS  0 RECORDS                                     
  460      LABEL RECORDS ARE OMITTED                                      
  470      DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
  480  01  SEQRDS-SYSIN-RECORD.                                           
  481   02 STD-NO          PIC 9(03).                                                         
  482   02 STD-NAME        PIC X(20).                                                         
  483   02 STD-GENDER      PIC X(07).                                                         
  484   02 FILLER          PIC X(50).                                                         

  520  WORKING-STORAGE SECTION.                                           
  560  77 N PIC 99999999 COMP VALUE 5.                                    
  570  77 WS-FS           PIC 9(02).                                
  580  01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
  590       88 EOF-SW         VALUE 'Y'.                               
  600       88 NOT-EOF-SW     VALUE 'N'.                                
  670 ***                                                                 
  680 ***                                                                 
  690 ***                                                                 
  700  PROCEDURE DIVISION.                                                
  710 **                                                                  
  720 **                                                                  
  730  MAIN-PART.                                                         
  800      OPEN INPUT SEQRDS-SYSIN.                                       
  810      PERFORM RDR-IT UNTIL EOF-SW.                                   
  860      CLOSE SEQRDS-SYSIN.                                            
  900      STOP RUN.                                                      
  910  RDR-IT.
  920       READ SEQRDS-SYSIN 
  921       AT END MOVE 'Y' TO WS-EOF-SW.
  922       IF NOT-EOF-SW 
  923          DISPLAY 'CURRENT RECORD : ' SEQRDS-SYSIN-RECORD. 
