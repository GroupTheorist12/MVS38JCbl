//HELLOA2  JOB (BAL),
//             'HELLO ASM2',
//             CLASS=A,
//             MSGCLASS=A,
//             TIME=1440,
//             MSGLEVEL=(1,1)
//HELLOA2  EXEC ASMFCG,PARM.ASM=(OBJ,NODECK),MAC1='SYS2.MACLIB',
//             REGION.GO=128K,PARM.GO='/2000'
//ASM.SYSIN DD *
*        1         2         3         4         5         6         71
*23456789*12345*789012345678901234*678901234567890123456789012345678901
        PRINT NOGEN              don't show macro expansions
HEWO    START 0                  start main code csect at base 0
        SAVE  (14,12)            Save input registers
        LR    R12,R15            base register := entry address
        USING HEWO,R12           declare base register
        ST    R13,SAVE+4         set back pointer in current save area
        LR    R2,R13             remember callers save area
        LA    R13,SAVE           setup current save area
        ST    R13,8(R2)          set forw pointer in callers save area
*
        WTO   'FUCK ME!!!'       write the message  
*
        L     R13,SAVE+4         get old save area back
        RETURN (14,12),RC=0      return to OS
*
*
* File and work area definitions
*
SAVE     DS    18F                local save area
        YREGS ,
        END   HEWO               define main entry point
/*
//GO.SYSPRINT DD SYSOUT=*
//
