//HERCALL2 JOB  (SETUP),
//             'Called 3',
//             CLASS=A,
//             MSGCLASS=H,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//********************************************************************
//*
//* NAME: HERCALL2.JCL
//*
//* DESC: COBOL COMPILE
//*
//********************************************************************
//CALLED EXEC COBUC,
//            PARM.COB='LOAD,SIZE=2048K,BUF=1024K,LIB,OBJECT'
//COB.SYSIN DD  DISP=SHR,DSN=HERC01.TEST.SOURCE(CALLED)
//COB.SYSLIN DD  DISP=SHR,DSN=HERC01.TEST.OBJ(CALLED)
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//
/* 
//GO.SYSPRINT DD SYSOUT=A
//
