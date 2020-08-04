//HERCALL4 JOB  (SETUP),
//             'Main 4',
//             CLASS=A,
//             MSGCLASS=A,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//********************************************************************
//*
//* NAME: HEMV6.JCL
//*
//* DESC: COBOL COMPILE, LINK, GO TEST
//*
//********************************************************************
//MAIN  EXEC COBUCLG,
//            PARM.COB='LOAD,SIZE=2048K,BUF=1024K,LIB'
//COB.SYSLIB DD DSN=HERC01.TEST.SOURCE,DISP=SHR
//COB.SYSPUNCH DD SYSOUT=B
//COB.SYSIN DD DSN=HERC01.TEST.SOURCE(MAIN),DISP=SHR
//LKED.SYSLIN DD
//         DD DSN=HERC01.TEST.OBJ(CALLED),DISP=SHR
//LKED.SYSLIB DD DSNAME=SYS1.COBLIB,DISP=SHR
//            DD DSNAME=SYS1.LINKLIB,DISP=SHR
//GO.SYSOUT DD SYSOUT=*
//
