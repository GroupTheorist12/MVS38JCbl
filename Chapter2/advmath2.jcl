//HERCADM JOB (COBOL),
//             'Adv Math',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//ADVMATH   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID. 'ADVMATH'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   WORKING-STORAGE SECTION.
000006   01 WS-N1 PIC 9(3) VALUE 5.
000007   01 WS-N2 PIC 9(4) VALUE 7.
000008   01 WS-N3 PIC 9(4) VALUE 8.
000009   01 WS-NA PIC 9(3) VALUE 80.
000010   01 WS-NB PIC 9(3) VALUE 20.
000011   01 WS-NC PIC 9(3).
000012
000013 PROCEDURE DIVISION.
000014     COMPUTE WS-NC = (WS-N1 * WS-N2) - (WS-NA / WS-NB) + WS-N3.
000015     DISPLAY 'WS-NUM1     : ' WS-N1
000016     DISPLAY 'WS-NUM2     : ' WS-N2
000017     DISPLAY 'WS-NUM3     : ' WS-N3
000018     DISPLAY 'WS-NUMA     : ' WS-NA
000019     DISPLAY 'WS-NUMB     : ' WS-NB
000020     DISPLAY 'Result of compute is     : ' WS-NC
000021
000022     STOP RUN.
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//        
        