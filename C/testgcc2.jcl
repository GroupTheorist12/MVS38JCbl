//TESTGCC JOB (SETUP),
//            'Test GCCMVS',
//            CLASS=A,
//            MSGCLASS=A,
//            REGION=8M,
//            MSGLEVEL=(1,1),
//            USER=HERC01,PASSWORD=CUL8TR                                
//********************************************************************
//*
//* Name: SYS2.JCLLIB(TESTGCC)
//*
//* Desc: GCC for MVS compile, link and go
//*
//********************************************************************
//*
//S1      EXEC GCCCLG
//COMP.SYSIN DD DSN=HERC01.CODE.SOURCE(HASHME),DISP=SHR             
//LKED.SYSLMOD DD DSN=HERC01.CODE.LOADLIB(HASHME),DISP=SHR
//
