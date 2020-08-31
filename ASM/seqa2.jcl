//SEQA2  JOB (BAL),
//             'HELLO ASM2',
//             CLASS=A,
//             MSGCLASS=A,
//             TIME=1440,
//             MSGLEVEL=(1,1)
//SEQA2  EXEC ASMFCG,PARM.ASM=(OBJ,NODECK),MAC1='SYS2.MACLIB',
//             REGION.GO=128K,PARM.GO='/2000'
//ASM.SYSIN DD *
*        1         2         3         4         5         6         71
*23456789*12345*789012345678901234*678901234567890123456789012345678901
        PRINT NOGEN              don't show macro expansions
SEQA1   START 0                  start main code csect at base 0
        SAVE  (14,12)            Save input registers
        LR    R12,R15            base register := entry address
        USING SEQA1,R12          declare base register
        ST    R13,SAVE+4         set back pointer in current save area
        LR    R2,R13             remember callers save area
        LA    R13,SAVE           setup current save area
        ST    R13,8(R2)          set forw pointer in callers save area
*
        OPEN  (SYSPRINT,OUTPUT)  open SYSPRINT
        LTR   R15,R15            test return code
        BNE   ABND8              abort if open failed
        OPEN  (SYSIN,INPUT)      open TEACHERS record
        LTR   R15,R15            test return code
        BNE   ABND8              abort if open failed

LOOP    GET   SYSIN,IREC         Read a single teacher record
        PUT   SYSPRINT,IREC      write the record to SYSPRINT
        B     LOOP               Repeat

ATEND   CLOSE SYSIN               close SYSIN  
        CLOSE SYSPRINT            close SYSPRINT
        

*
        L     R13,SAVE+4         get old save area back
        RETURN (14,12),RC=0      return to OS
*
ABND8    ABEND 8                  bail out with abend U008

*
* File and work area definitions
*
SAVE     DS    18F                local save area
IREC     DS    CL80               Teacher record


SYSPRINT DCB   DSORG=PS,MACRF=PM,DDNAME=SYSPRINT,                      X
               RECFM=FBA,LRECL=80,BLKSIZE=800
SYSIN    DCB   DSORG=PS,MACRF=GM,EODAD=ATEND,DDNAME=SYSIN,             X
               RECFM=FBA,LRECL=80,BLKSIZE=0               
        YREGS ,
        END   SEQA1              define main entry point
/*
//GO.SYSPRINT DD SYSOUT=*
//GO.SYSIN DD *
 732BENSON, E.T.   PHD N5156
 218HINCKLEY, G.B. MBA N5509
 854KIMBALL, S.W.  PHD Y5594
 626YOUNG, B.      MBA Y5664
 574SMITH, J.      MS  Y5320
/*
//
