//HERRND1 JOB (COBOL),
//             'Rnd Rd 2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//RAND1   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID. 'RAND1'.
000003 ENVIRONMENT DIVISION.
000004 INPUT-OUTPUT SECTION.
000005 FILE-CONTROL.
000006      SELECT SEQRDS-SYSIN                                            
000007        ASSIGN TO UT-S-STUDENTS                                    
000008        ORGANIZATION IS INDEXED
000009        ACCESS IS RANDOM
000010        RECORD KEY IS STD-NO.
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
000025
000026 WORKING-STORAGE SECTION.
000027 01  WS-SYSIN-RECORD.                                           
000028  02 STD-NO-IN          PIC 9(03).                                                         
000029  02 STD-NAME-IN        PIC X(20).                                                         
000030  02 STD-GENDER-IN      PIC X(07).                                                         
000031  02 FILLER             PIC X(50).                                                         
000032
000033 PROCEDURE DIVISION.
000034     OPEN INPUT SEQRDS-SYSIN.
000035     MOVE 103 TO STD-NO.
000036      
000037      READ SEQRDS-SYSIN RECORD INTO WS-SYSIN-RECORD
000038        KEY IS STD-NO
000039        INVALID KEY DISPLAY 'Invalid Key'
000040        NOT INVALID KEY DISPLAY WS-SYSIN-RECORD.
000041      
000042      CLOSE SEQRDS-SYSIN.
000043      STOP RUN.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
//STUDENTS DD DSN=HERC01.TEST.CNTL(STUDENTS),DISP=SHR
/*
//        
        