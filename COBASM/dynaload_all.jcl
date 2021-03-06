//HETSTD JOB (COBOL), 
//             'Test Dynaload',
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
//SYSLIN DD DSNAME=&&OBJ,DISP=(NEW,PASS),UNIT=SYSDA,            
//             SPACE=(80,(500,100))                                
//SYSIN  DD DSN=HERC01.CODE.SOURCE(TESTDYNA),DISP=SHR
//SYSOUT DD SYSOUT=* 
//SYSPUNCH DD SYSOUT=* 
//SYSLIB DD   DSNAME=SYS1.COBLIB,DISP=SHR                          
//ASMF2     EXEC PGM=IFOX00,REGION=2048K
//SYSLIB    DD DSN=SYS1.AMODGEN,DISP=SHR
//          DD DSN=SYS1.AMACLIB,DISP=SHR
//          DD DSN=SYS2.MACLIB,DISP=SHR 
//SYSUT1    DD DISP=(NEW,DELETE),SPACE=(1700,(900,100)),UNIT=SYSDA
//SYSUT2    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSUT3    DD DISP=(NEW,DELETE),SPACE=(1700,(600,100)),UNIT=SYSDA
//SYSPRINT  DD SYSOUT=*
//SYSPUNCH  DD DSN=&&OBJ,UNIT=SYSDA,SPACE=(CYL,1),DISP=(MOD,PASS)
//SYSIN     DD DSN=HERC01.CODE.ASM(DYNALOAD),DISP=SHR
//LKED     EXEC PGM=IEWL,
//             COND=(5,LT,COB),
//             PARM='LIST,MAP,XREF,LET,RENT'
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSLIB DD   DSNAME=SYS1.COBLIB,DISP=SHR                          
//SYSUT1    DD UNIT=SYSDA,SPACE=(TRK,(5,5))
//SYSLIN    DD DSN=&&OBJ,DISP=(OLD,DELETE)
//          DD *
 NAME TESTDYNA(R)
//