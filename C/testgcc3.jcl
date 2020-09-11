//HEHASH JOB MSGCLASS=A,MSGLEVEL=(1,1),                                 00000010
//             USER=HERC01,PASSWORD=CUL8TR                              00000011  
//*                                                                     00000020
//*  EXECUTE THE HASHME TEST                                            00000030
//*  ,COND=((12,EQ),EVEN)                                               00000040
//STEP1 EXEC PGM=HASHME                                                 00000050
//STEPLIB DD DSN=HERC01.TEST.LOADLIB,DISP=SHR                           00000060
//SYSOUT  DD SYSOUT=*                                                   00000070
//SYSPRINT DD   SYSOUT=*,DCB=(LRECL=132,BLKSIZE=1320)
//SYSABEND DD   SYSOUT=*
//SYSIN    DD   DUMMY
//SYSTERM  DD   SYSOUT=A,DCB=(LRECL=132,BLKSIZE=1320)
//*                                                                     00000080
