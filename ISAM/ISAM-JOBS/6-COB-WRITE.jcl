//HERC01W JOB MSGCLASS=H,NOTIFY=HERC01,
//            USER=HERC01,PASSWORD=CUL8TR
//***
//***  ADD A RECORD TO ISAM DATASET WITH A COBOL PROGRAM
//***
//ISRNDW EXEC COBUCLG                                                  
//COB.SYSLIB DD DSN=SYS1.COBLIB,DISP=SHR                          
//COB.SYSPUNCH DD SYSOUT=B                                              
//COB.SYSIN DD *                                                        
       IDENTIFICATION DIVISION.                                         
                                                                        
       PROGRAM-ID.    ISRNDW.                                           
       AUTHOR.        RENE FERLAND.                                     
       DATE-WRITTEN   JUNE 5, 2020.                                     
       REMARKS.       ILLUSTRATE ISAM RECORD WRITE.                     
                                                                        
                                                                        
       ENVIRONMENT DIVISION.                                            
                                                                        
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
           SELECT ISAM-FILE                                             
              ASSIGN TO DA-I-ISAMDD                                     
              RECORD KEY IS KEY-VAL                                     
              NOMINAL KEY IS WS-KEY-VAL                                 
              ACCESS MODE IS RANDOM.                                    
                                                                        
                                                                        
       DATA DIVISION.                                                   
                                                                        
       FILE SECTION.                                                    
       FD  ISAM-FILE                                                    
           LABEL RECORDS ARE STANDARD                                   
           RECORDING MODE IS F                                          
           RECORD CONTAINS 81 CHARACTERS                                
           BLOCK CONTAINS 10 RECORDS                                    
           DATA RECORD IS ISAM-RECORD.                                  
       01  ISAM-RECORD.                                                 
           05  DELETE-BYTE     PIC X.                                   
           05  KEY-VAL         PIC X(5).                                
           05  NAME            PIC X(20).                               
           05  FILLER-1        PIC X(3).                                
           05  POLICY-TYPE     PIC X.                                   
           05  PREMIUM         PIC 9999V99.                             
           05  DUE-MONTH       PIC 99.                                  
           05  DUE-DAY         PIC 99.                                  
           05  YEAR-TO-DATE    PIC 9999V99.                             
           05  FILLER-2        PIC X(4).                                
           05  FIRST-YEAR      PIC 99.                                  
           05  FILLER-3        PIC X(29).                               
                                                                        
       WORKING-STORAGE SECTION.                                         
       01  WS-KEY-VAL          PIC X(5).                                
                                                                        
                                                                        
       PROCEDURE DIVISION.                                              
                                                                        
       100-MAIN.                                                        
           OPEN I-O ISAM-FILE.                                          
                                                                        
           MOVE LOW-VALUE TO DELETE-BYTE.                               
           MOVE '13029' TO KEY-VAL.                                     
           MOVE 'RIGG, MARLENE       ' TO NAME.                         
           MOVE 'A' TO POLICY-TYPE.                                     
           MOVE 1759.00 TO PREMIUM.                                     
           MOVE 11 TO DUE-MONTH.                                        
           MOVE 10 TO DUE-DAY.                                          
           MOVE 1050.00 TO YEAR-TO-DATE.                                
           MOVE 38 TO FIRST-YEAR.                                       
           MOVE SPACES TO FILLER-1.
           MOVE SPACES TO FILLER-2.
           MOVE SPACES TO FILLER-3.

           MOVE '13029' TO WS-KEY-VAL.                                  
           WRITE ISAM-RECORD                                            
                INVALID KEY PERFORM 200-BAD-WRITE.                      
                                                                        
           CLOSE ISAM-FILE.                                             
           GOBACK.
                                                                        
       200-BAD-WRITE.                                                   
           DISPLAY 'INVALID KEY ' WS-KEY-VAL.                           
/*                                                                      
//LKED.SYSIN DD DUMMY
//GO.ISAMDD DD DSN=HERC01.POLYISAM,DISP=OLD,
//             DCB=DSORG=IS,
//GO.SYSOUT DD SYSOUT=*
//***
//***  LIST ISAM DATASET
//***
//LIST   EXEC PGM=IEBISAM,PARM='PRINTL,N'
//SYSPRINT DD SYSOUT=*
//SYSUT1   DD DSN=HERC01.POLYISAM,DISP=SHR,
//            DCB=DSORG=IS
//SYSUT2   DD SYSOUT=*
//
