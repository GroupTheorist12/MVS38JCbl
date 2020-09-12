//HECALLEE JOB (COBOL), 
//             'Callee',
//             CLASS=A,
//             MSGCLASS=H,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//IEBGENER EXEC PGM=IEBGENER,REGION=128K
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  *
000001 IDENTIFICATION DIVISION.
000002 PROGRAM-ID.     'CALLEE'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   LINKAGE SECTION.
000006   01 LS-PARM1.
000007      05 LS-STUDENT-ID PIC 9(4).
000008      05 LS-STUDENT-NAME PIC A(15).
000009      
000010 PROCEDURE DIVISION USING LS-PARM1.
000011     DISPLAY 'In Called Program'.
000012     MOVE 2222 TO LS-STUDENT-ID.
000013     MOVE 'MARLENE RIGG' TO LS-STUDENT-NAME.
000014     MOVE ZERO TO RETURN-CODE. 
000015     GOBACK.      
000016           
/*
//SYSUT2   DD DSN=HERC01.TEST.SOURCE(CALLEE),DISP=OLD
//SYSIN    DD DUMMY
//

