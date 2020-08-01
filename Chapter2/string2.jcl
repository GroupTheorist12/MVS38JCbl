//HERCSTR2 JOB (COBOL),
//             'Strings 2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//STRING2   EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID.     'STRING2'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   WORKING-STORAGE SECTION.
000006   01 WS-DATA		PIC X(10) VALUE 'DD-MM-YYYY'.         
000007 PROCEDURE DIVISION.                                             
000008     DISPLAY 'EXAMINE TALLYING REPLACING....'.                   
000009     DISPLAY 'WS-DATA BEFORE EXAMINE: ' WS-DATA. 
000010     EXAMINE WS-DATA TALLYING ALL '-'                     
000011     REPLACING  BY '/'.                                   
000012     DISPLAY 'DATA AFTER TALLYING REPLACING : ' WS-DATA.          
000013     DISPLAY 'TALLY: ' TALLY.
000014     STOP RUN.                                                   
 /*
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//        
        