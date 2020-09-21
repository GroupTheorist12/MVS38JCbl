//HEHIC2 JOB (COBOL), 
//             'Cobol HI2',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//COB  EXEC  PGM=IKFCBL00,                          
//           PARM='LOAD,SUPMAP,SIZE=2048K,BUF=1024K'
//SYSUT1 DD UNIT=SYSDA,SPACE=(460,(700,100))        
//SYSUT2 DD UNIT=SYSDA,SPACE=(460,(700,100))        
//SYSUT3 DD UNIT=SYSDA,SPACE=(460,(700,100))        
//SYSUT4 DD UNIT=SYSDA,SPACE=(460,(700,100))        
//SYSPRINT  DD SYSOUT=*
//SYSLIN DD DSNAME=&&OBJ,DISP=(MOD,PASS),UNIT=SYSDA,            
//             SPACE=(80,(500,100))                                
//SYSIN     DD *
000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.     'HEMV1'.
000300 ENVIRONMENT DIVISION.
001000 DATA DIVISION.
100000 PROCEDURE DIVISION.
100100 00-MAIN.
100500     DISPLAY 'Hello MVS !' UPON CONSOLE.
100600     STOP RUN.
/*
//LKED     EXEC PGM=IEWL,
//             PARM='LIST,XREF,LET',COND=(5,LT,COB)
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//* SLIB    DD DSN=SYS1.LINKLIB,DISP=SHR
//SYSLIB DD   DSNAME=SYS1.COBLIB,DISP=SHR                          
//SYSUT1    DD UNIT=SYSDA,SPACE=(TRK,(5,5))
//SYSLIN    DD DSN=&&OBJ,DISP=(OLD,DELETE)
//          DD *
 NAME HEMV1(R)
//*-------------------------------------------------------------------
//HEMV1     EXEC PGM=HEMV1
//STEPLIB   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//