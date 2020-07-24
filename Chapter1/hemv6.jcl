//HERCHE6 JOB  (SETUP),
//             'TEST COBOL',
//             CLASS=A,
//             MSGCLASS=H,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//********************************************************************
//*
//* NAME: SYS2.JCLLIB(TESTCOB)
//*
//* DESC: TEST COBOL INSTALLATION
//*
//********************************************************************
//HEMV6 EXEC COBUCLG
//COB.SYSIN DD *
  001  IDENTIFICATION DIVISION.
  002  PROGRAM-ID.  'HELLO'.
  003  ENVIRONMENT DIVISION.
  004  CONFIGURATION SECTION.
  005  SOURCE-COMPUTER.  IBM-360.
  006  OBJECT-COMPUTER.  IBM-360.
  0065 SPECIAL-NAMES.
  0066     CONSOLE IS CNSL.
  007  DATA DIVISION.
  008  WORKING-STORAGE SECTION.
  009  77  HELLO-CONST   PIC X(12) VALUE 'HELLO, MVS6'.
  075  PROCEDURE DIVISION.
  090  000-DISPLAY.
  100      DISPLAY HELLO-CONST UPON CNSL.
  110      STOP RUN.
/* 
//LKED.SYSLMOD DD DSNAME=HERC01.TEST.LOADLIB(HEMV6),DISP=SHR
//LKED.SYSLIB DD DSNAME=SYS1.COBLIB,DISP=SHR
//            DD DSNAME=SYS1.LINKLIB,DISP=SHR
//GO.SYSPRINT DD SYSOUT=A
//
