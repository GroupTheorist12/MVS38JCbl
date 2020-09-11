//HEHASH4 JOB (SETUP),
//            'He Hash',
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
//S1      EXEC GCCCLG,COPTS='-v'
//COMP.SYSIN DD DSN=HERC01.TEST.CNTL(HASHME),DISP=SHR             
//
