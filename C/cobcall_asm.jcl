//HECALLCA JOB (COBOL), 
//             'Asm c routine',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//********************************************************************* 00700000
//* ASSEMBLE COBCALLC TO OBJECT DATASET                               * 00710000
//********************************************************************* 00720000
//*                                                                     00730000
//ASM     EXEC PGM=IEUASM,REGION=1024K,                                 00740000
//             PARM='LIST,NODECK,OBJECT'                                00750000
//SYSLIB   DD  DSN=SYS1.MACLIB,DISP=SHR                                 00760000
//         DD  DSN=PDPCLIB.MACLIB,DISP=SHR
//SYSUT1   DD  UNIT=SYSDA,SPACE=(1700,(600,100))                        00770000
//SYSUT2   DD  UNIT=SYSDA,SPACE=(1700,(300,50))                         00780000
//SYSUT3   DD  UNIT=SYSDA,SPACE=(1700,(300,50))                         00790000
//SYSPRINT DD  SYSOUT=*                                                 00800000
//SYSPUNCH DD  DUMMY                                                    00810000
//SYSGO    DD  DSN=HERC01.TEST.LOADLIB(COBCALLC),DISP=(OLD,DELETE),     00820000
//             UNIT=3380,VOL=SER=PUB002,SPACE=(TRK,(5,,1))              00830000
//SYSIN    DD  DSN=HERC01.TEST.ASM(COBCALLC),DISP=SHR                   00840000
//                                                                      00850000
