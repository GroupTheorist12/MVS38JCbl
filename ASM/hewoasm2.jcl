//HEWO#ASM JOB 'S322-0C4','WFJM',
//      CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1),
//      REGION=128K,TIME=(1,0),PRTY=8
//CLG EXEC ASMFCLG,
//      MAC1='SYS1.MACLIB',
//      PARM.ASM='NODECK,LOAD',
//      PARM.LKED='MAP,LIST,LET,NCAL',
//      COND.LKED=(8,LE,ASM),
//      PARM.GO='',
//      COND.GO=((8,LE,ASM),(4,LT,LKED))
//ASM.SYSUT1 DD DSN=&&SYSUT1,UNIT=SYSDA,SPACE=(1700,(600,100))
//ASM.SYSUT2 DD DSN=&&SYSUT2,UNIT=SYSDA,SPACE=(1700,(300,50))
//ASM.SYSUT3 DD DSN=&&SYSUT3,UNIT=SYSDA,SPACE=(1700,(300,50))
//ASM.SYSGO  DD DSN=&&OBJSET,UNIT=SYSDA,SPACE=(80,(2000,500))
//ASM.SYSIN  DD *
*        1         2         3         4         5         6         71
*23456789*12345*789012345678901234*678901234567890123456789012345678901
        PRINT NOGEN              don't show macro expansions
HEWO     START 0                  start main code csect at base 0
        SAVE  (14,12)            Save input registers
        LR    R12,R15            base register := entry address
        USING HEWO,R12           declare base register
        ST    R13,SAVE+4         set back pointer in current save area
        LR    R2,R13             remember callers save area
        LA    R13,SAVE           setup current save area
        ST    R13,8(R2)          set forw pointer in callers save area
*
        OPEN  (SYSPRINT,OUTPUT)  open SYSPRINT
        LTR   R15,R15            test return code
        BNE   ABND8              abort if open failed
        PUT   SYSPRINT,MSG       write the message
        CLOSE SYSPRINT           close SYSPRINT
*
        L     R13,SAVE+4         get old save area back
        RETURN (14,12),RC=0      return to OS
*
ABND8    ABEND 8                  bail out with abend U008
*
* File and work area definitions
*
SAVE     DS    18F                local save area
MSG      DC    CL133' Hello World !'
SYSPRINT DCB   DSORG=PS,MACRF=PM,DDNAME=SYSPRINT,                      X
              RECFM=FBA,LRECL=133,BLKSIZE=1330
        YREGS ,
        END   HEWO               define main entry point
/*
//GO.SYSUDUMP DD SYSOUT=*,OUTLIM=2000
//GO.SYSPRINT DD SYSOUT=*,OUTLIM=5000
//GO.SYSIN DD *
/*
//
