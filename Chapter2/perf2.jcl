//HERPER2 JOB (COBOL),
//             'PERFORM 2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//PERF2   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID. PERF2.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.  
000005 PROCEDURE DIVISION.
000006   A-PARA.
000007     DISPLAY 'IN A-PARA'
000008     PERFORM C-PARA THRU E-PARA.
000009   
000010   B-PARA.
000011     DISPLAY 'IN B-PARA'.
000012     STOP RUN.
000013   
000014   C-PARA.
000015     DISPLAY 'IN C-PARA'.
000016   
000017   D-PARA.
000018     DISPLAY 'IN D-PARA'.
000019   
000020   E-PARA.
000021     DISPLAY 'IN E-PARA'.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//        
        