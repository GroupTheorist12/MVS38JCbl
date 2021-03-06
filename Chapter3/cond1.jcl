//HERCIF1 JOB (COBOL),
//             'If Stmnt Test',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//COND1   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID.     'COND1'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   WORKING-STORAGE SECTION.
000006   01 WS-NUM1 PIC 9(9).
000007   01 WS-NUM2 PIC 9(9).
000008
000009 PROCEDURE DIVISION.
000010 00-MAIN.
000011     MOVE 25 TO WS-NUM1.
000012     MOVE 15 TO WS-NUM2.
000013     IF WS-NUM1 > WS-NUM2 THEN
000014        DISPLAY 'WS-NUM1 > WS-NUM2'
000015     ELSE
000016        DISPLAY 'WS-NUM2 > WS-NUM1'.
000017*    ENDIF        
000018     STOP RUN.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//        
        