//HERHE2 JOB (COBOL),
//             'Hello MVS 2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//HEMV2    EXEC COBUCG,
//         PARM.COB='FLAGW,LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//COB.SYSPUNCH DD DUMMY
//COB.SYSIN    DD DISP=SHR,DSN=HERC01.TEST.SOURCE(HEMV2)
//COB.SYSLIB   DD DSNAME=SYS1.COBLIB,DISP=SHR
//GO.SYSIN  DD * 
//GO.SYSOUT DD SYSOUT=*
/*
//

