//HEHASH4 JOB (SETUP),
//            'Cobol calling C',
//            CLASS=A,
//            MSGCLASS=A,
//            REGION=8M,
//            MSGLEVEL=(1,1),
//            USER=HERC01,PASSWORD=CUL8TR                                
//********************************************************************
//*
//* Name: SYS2.JCLLIB(COBCALLC)
//*
//* Desc: GCC for MVS compile, link
//*
//********************************************************************
//*
//S1 EXEC GCCC,COPTS='-S',INFILE='HERC01.CODE.SOURCE(HASHME)'
//COMP.OUT DD DSN=HERC01.CODE.ASM(HASHME),DISP=SHR      
//*COMP.SYSIN DD DSN=HERC01.TEST.SOURCE(COBCALLC),DISP=SHR
//*LKED.SYSLMOD DD DSN=HERC01.TEST.LOADLIB(COBCALLC),DISP=SHR
//SYSOUT  DD SYSOUT=*                                                   
//SYSIN    DD   DUMMY
//
