
//HERCALL2 JOB (COBOL), 
//             'Cobcall',
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
000002 PROGRAM-ID.     'COBCALL'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   WORKING-STORAGE SECTION.
         01 X PIC S9(9) COMPUTATIONAL.

000008      
000009 PROCEDURE DIVISION.
           DISPLAY 'IN CALLING PROGRAM'.
           MOVE 10 TO X.
000010     CALL 'CENTRY' USING X.
000013     STOP RUN.
/*
//SYSUT2   DD DSN=HERC01.TEST.SOURCE(COBCALL),DISP=OLD
//SYSIN    DD DUMMY
//

