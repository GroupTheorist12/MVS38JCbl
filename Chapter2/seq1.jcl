//HERSQ1 JOB (COBOL),
//             'Seq Rd',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//SEQ1   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.                                           
000002 PROGRAM-ID.  'SEQ1'.                                             
000003 ENVIRONMENT DIVISION.                                              
000004 CONFIGURATION SECTION.                                             
000005 SOURCE-COMPUTER.  IBM-360.                                         
000006 OBJECT-COMPUTER.  IBM-360.                                         
000007 INPUT-OUTPUT SECTION.                                              
000008 FILE-CONTROL.                                                      
000009     SELECT SEQRDS-SYSIN                                            
000010        ASSIGN TO UT-S-STUDENTS.                                    
000011 DATA DIVISION.                                                     
000012 FILE SECTION.                                                      
000013 FD  SEQRDS-SYSIN                                                   
000014     RECORDING MODE IS F                                            
000015     RECORD CONTAINS 80 CHARACTERS                                  
000016     BLOCK  CONTAINS  0 RECORDS                                     
000017     LABEL RECORDS ARE OMITTED                                      
000018     DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
000019 01  SEQRDS-SYSIN-RECORD.                                           
000020  02 STD-NO          PIC 9(03).                                                         
000021  02 STD-NAME        PIC X(20).                                                         
000022  02 STD-GENDER      PIC X(07).                                                         
000023  02 FILLER          PIC X(50).                                                         
000024
000025 WORKING-STORAGE SECTION.                                           
000026 01 N PIC 99999999 COMP VALUE 5.                                    
000027 01 WS-FS           PIC 9(02).                                
000028 01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
000029      88 EOF-SW         VALUE 'Y'.                               
000030      88 NOT-EOF-SW     VALUE 'N'.                                
000031 PROCEDURE DIVISION.                                                
000032 MAIN-PART.                                                         
000033     OPEN INPUT SEQRDS-SYSIN.                                       
000034     PERFORM RDR-IT UNTIL EOF-SW.                                   
000035     CLOSE SEQRDS-SYSIN.                                            
000036     STOP RUN.                                                      
000037 RDR-IT.
000038      READ SEQRDS-SYSIN 
000039      AT END MOVE 'Y' TO WS-EOF-SW.
000040      IF NOT-EOF-SW 
000041         DISPLAY 'CURRENT RECORD : ' SEQRDS-SYSIN-RECORD. 
000042         EXIT.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
//STUDENTS DD DSN=HERC01.TEST.CNTL(STUDENTS),DISP=SHR
/*
//        
        