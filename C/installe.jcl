//HERC01T JOB MSGCLASS=A,MSGLEVEL=(1,1),                                00000010
//             USER=HERC01,PASSWORD=CUL8TR                              00000011  
//*                                                                     00000020
//*  EXECUTE THE DYNALOAD TEST                                          00000030
//*                                                                     00000040
//STEP1 EXEC PGM=TESTDYNA                                               00000050
//STEPLIB DD DSN=HERC01.DYNALOAD.LOADLIB,DISP=SHR                       00000060
//SYSOUT  DD SYSOUT=*                                                   00000070
//*                                                                     00000080
