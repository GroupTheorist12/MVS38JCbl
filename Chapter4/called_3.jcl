//HERCALL3 JOB  (SETUP),
//             'Called 3',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//********************************************************************
//*
//* NAME: HERCALL3.JCL
//*
//* DESC: COBOL COMPILE
//*
//********************************************************************
//CALLED EXEC COBUC,
//            PARM.COB='LOAD,SIZE=2048K,BUF=1024K,LIB,OBJECT'
//COB.SYSIN DD  DISP=SHR,DSN=HERC01.CODE.SOURCE(CALLED)
//COB.SYSLIN DD  DISP=SHR,DSN=HERC01.CODE.LOADLIB(CALLED)
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//
/* 
//GO.SYSPRINT DD SYSOUT=A
//