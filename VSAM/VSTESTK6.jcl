//VSTESTK6 JOB 'JAY MOSELEY',CLASS=A,MSGLEVEL=(1,1),MSGCLASS=A,         00010000
//             REGION=4096K                                             00020000
//*                                                                     00030000
//********************************************************************* 00040000
//* COBOL MODULE: KSDSSSEQ     VSAM DATASET: VSTESTKS.CLUSTER (KSDS)    00050000
//*                                                                     00060000
//* TESTS START AND READ FUNCTIONS AGAINST KSDS DATASET                 00070000
//********************************************************************* 00080000
//*                                                                     00090000
//COB     EXEC PGM=IKFCBL00,REGION=1024K,                               00100000
//             PARM='LOAD,LIST,DMAP,BUF=8192,LIB'                       00110000
//SYSLIB   DD  DSN=MVS.VSAMIO.SOURCE,DISP=SHR                           00120000
//SYSPRINT DD  SYSOUT=A                                                 00130000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00140000
//SYSUT2   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00150000
//SYSUT3   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00160000
//SYSUT4   DD  UNIT=SYSDA,SPACE=(460,(700,100))                         00170000
//SYSLIN   DD  DSN=&LOADSET,DISP=(MOD,PASS),UNIT=SYSDA,                 00180000
//             SPACE=(80,(500,100))                                     00190000
//SYSIN    DD  DSN=MVS.VSAMIO.SOURCE(KSDSSSEQ),DISP=SHR                 00200000
//*                                                                     00210000
//LKED    EXEC PGM=IEWL,REGION=1024K,COND=(5,LT),                       00220000
//             PARM='LIST,XREF,LET'                                     00230000
//SYSLIN   DD  DSN=*.COB.SYSLIN,DISP=(OLD,PASS)                         00240000
//         DD  DSN=MVS.VSAMIO.OBJECT(VSAMIO),DISP=SHR                   00250000
//SYSLMOD  DD  DSN=&GODATA(RUN),DISP=(NEW,PASS),UNIT=SYSDA,             00260000
//             SPACE=(1024,(50,20,1))                                   00270000
//SYSLIB   DD  DSN=SYS1.COBLIB,DISP=SHR                                 00280000
//SYSUT1   DD  UNIT=SYSDA,SPACE=(1024,(50,20))                          00290000
//SYSPRINT DD  SYSOUT=A                                                 00300000
//*                                                                     00310000
//GO      EXEC PGM=*.LKED.SYSLMOD,REGION=1024K,COND=(5,LT,LKED)         00320000
//SYSOUT   DD  SYSOUT=A                                                 00330000
//SYSUDUMP DD  SYSOUT=A                                                 00340000
//KSDSF01  DD  DSN=VSTESTKS.CLUSTER,DISP=OLD                            00350000
//                                                                      00360000
