//HERSQ2 JOB (COBOL),
//             'Seq Rd 2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//SEQ2   EXEC COBUCG,
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
000011     SELECT SEQRDS-SYSOUT                                            
000012        ASSIGN TO UT-S-STUDWRT.                                    
000013 DATA DIVISION.                                                     
000014 FILE SECTION.                                                      
000015 FD  SEQRDS-SYSIN                                                   
000016     RECORDING MODE IS F                                            
000017     RECORD CONTAINS 80 CHARACTERS                                  
000018     BLOCK  CONTAINS  0 RECORDS                                     
000019     LABEL RECORDS ARE OMITTED                                      
000020     DATA RECORD IS SEQRDS-SYSIN-RECORD.                            
000021 01  SEQRDS-SYSIN-RECORD.                                           
000022  02 STD-NO          PIC 9(03).                                                         
000023  02 STD-NAME        PIC X(20).                                                         
000024  02 STD-GENDER      PIC X(07).                                                         
000025  02 FILLER          PIC X(50).                                                         
000026
000027 FD  SEQRDS-SYSOUT                                                   
000028     RECORDING MODE IS F                                            
000029     RECORD CONTAINS 80 CHARACTERS                                  
000030     BLOCK  CONTAINS  0 RECORDS                                     
000031     LABEL RECORDS ARE OMITTED                                      
000032     DATA RECORD IS SEQRDS-SYSOUT-RECORD.                            
000033 01  SEQRDS-SYSOUT-RECORD.                                           
000034  05 STD-DATA        PIC X(80).                                                         
000035
000036 WORKING-STORAGE SECTION.                                           
000037 77 N PIC 99999999 COMP VALUE 5.                                    
000038 77 WS-FS           PIC 9(02).                                
000039 01 WS-EOF-SW       PIC X(01) VALUE 'N'.                      
000040      88 EOF-SW         VALUE 'Y'.                               
000041      88 NOT-EOF-SW     VALUE 'N'.                                
000042
000043 01  WS-SYSIN-RECORD.                                           
000044  02 STD-NO-IN          PIC 9(03).                                                         
000045  02 STD-NAME-IN        PIC X(20).                                                         
000046  02 STD-GENDER-IN      PIC X(07).                                                         
000047  02 FILLER             PIC X(50).                                                         
000048
000049 01  WS-SYSOUT-RECORD.                                           
000050  02 STD-NO-OUT          PIC 9(03).                                                         
000051  02 STD-NAME-OUT        PIC X(20).                                                         
000052  02 STD-GENDER-OUT      PIC X(07).                                                         
000053  02 FILLER              PIC X(50) VALUE SPACES.                                                         
000054 
000055 PROCEDURE DIVISION.                                                
000056 MAIN-PART.                                                         
000057     OPEN INPUT SEQRDS-SYSIN.
000058     OPEN OUTPUT SEQRDS-SYSOUT.                                        
000059     PERFORM RDR-WRTR-IT UNTIL EOF-SW.                                   
000060     CLOSE SEQRDS-SYSIN 
000061     CLOSE SEQRDS-SYSOUT.
000062     STOP RUN.                                                      
000063 RDR-WRTR-IT.
000064      READ SEQRDS-SYSIN INTO WS-SYSIN-RECORD 
000065      AT END MOVE 'Y' TO WS-EOF-SW.
000066      IF NOT-EOF-SW 
000067         MOVE STD-NO-IN TO STD-NO-OUT
000068         MOVE STD-NAME-IN  TO STD-NAME-OUT
000069         MOVE STD-GENDER-IN  TO STD-GENDER-OUT
000070         DISPLAY 'CURRENT RECORD : ' WS-SYSOUT-RECORD
000071         WRITE SEQRDS-SYSOUT-RECORD FROM 
000072           WS-SYSOUT-RECORD.     
000073
000074      
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
//STUDENTS DD DSN=HERC01.TEST.CNTL(STUDENTS),DISP=SHR
//STUDWRT DD DSN=HERC01.TEST.CNTL(STUDWRT),DISP=SHR

/*
//        
        