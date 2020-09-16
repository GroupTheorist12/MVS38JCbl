//HECALLC JOB (COBOL), 
//             'Hello',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//STEP5 EXEC COBUCL                                                     00003460
//COB.SYSIN DD DSN=HERC01.CODE.SOURCE(CALLER),DISP=SHR                  00003470
//LKED.SYSLIB DD                                                        00003480
//        DD DSN=HERC01.CODE.LOADLIB,DISP=SHR                           00003490
//LKED.SYSLMOD DD DSN=HERC01.CODE.LOADLIB(CALLER),DISP=SHR              00003500

