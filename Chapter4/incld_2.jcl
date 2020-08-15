
//HINCLD2 JOB (COBOL), 
//             'Include 2',
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
000002 PROGRAM-ID.     'MAIN'.
000003 ENVIRONMENT DIVISION.
000004 DATA DIVISION.
000005   WORKING-STORAGE SECTION.
000006   01 SQL-PARAMETER-VALUES COPY CPYBK.
000008      
000009 PROCEDURE DIVISION.
000012     MOVE 'select * from cars' TO WS-SQL.
           PERFORM EXEC-SQL-SELECT.
000013     STOP RUN.
000014 SQL-SECTION SECTION. COPY INCLD.   

/*
//SYSUT2   DD DSN=HERC01.TEST.SOURCE(USEINCLD),DISP=OLD
//SYSIN    DD DUMMY
//

