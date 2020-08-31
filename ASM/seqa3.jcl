//SEQA3  JOB (BAL),
//             'HELLO ASM2',
//             CLASS=A,
//             MSGCLASS=A,
//             TIME=1440,
//             MSGLEVEL=(1,1)
//SEQA3  EXEC ASMFCG,PARM.ASM=(OBJ,NODECK),MAC1='SYS2.MACLIB',
//             REGION.GO=128K,PARM.GO='/2000'
//ASM.SYSIN DD *
*        1         2         3         4         5         6         71
*23456789*12345*789012345678901234*678901234567890123456789012345678901
        PRINT NOGEN              don't show macro expansions
SEQA3   START 0                  start main code csect at base 0
        SAVE  (14,12)            Save input registers
        LR    R12,R15            base register := entry address
        USING SEQA3,R12          declare base register
        ST    R13,SAVE+4         set back pointer in current save area
        LR    R2,R13             remember callers save area
        LA    R13,SAVE           setup current save area
        ST    R13,8(R2)          set forw pointer in callers save area
*
        OPEN  (SYSPRINT,OUTPUT)  open SYSPRINT
        LTR   R15,R15            test return code
        BNE   ABND8              abort if open failed
        OPEN  (TEACHERS,INPUT)   open TEACHERS
        LTR   R15,R15            test return code
        BNE   ABND8              abort if open failed

LOOP    GET   TEACHERS,IREC      Read a single teacher record
        MVC   OTID,ITID          Move teacher ID Nbr to output     
        MVC   OTNAME,ITNAME      Move teacher Name to output
        MVC   OTDEG,ITDEG        Move highest degree to output
        MVC   OTTEN,ITTEN        Move tenure to output
        MVC   OTPHONE,ITPHONE    Move phone nbr to output

        PUT   SYSPRINT,OREC      write the record to SYSPRINT
        B     LOOP               Repeat

ATEND   CLOSE TEACHERS
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

*                                 INPUT RECORD 
IREC     DS    0CL80              Teacher record     
ITID     DS    CL4                Teacher ID nbr
ITNAME   DS    CL15               Teacher name
ITDEG    DS    CL4                Highest degree
ITTEN    DS    CL1                Tenured?
ITPHONE  DS    CL4                Phone nbr
FILL     DS    CL52               Fill   

*                                 OUTPUT RECORD
OREC     DS    0CL80              
OTID     DS    CL4                Teacher ID nbr
         DC    CL3' '
OTNAME   DS    CL15               Teacher name
         DC    CL3' '
OTDEG    DS    CL4                Highest degree
         DC    CL3' '
OTTEN    DS    CL1                Tenured?
         DC    CL3' '
OTPHONE  DS    CL4                Phone nbr
         DC    CL41' ' 

SYSPRINT DCB   DSORG=PS,MACRF=PM,DDNAME=SYSPRINT,                      X
               RECFM=FBA,LRECL=80,BLKSIZE=800
TEACHERS DCB   DSORG=PS,MACRF=GM,EODAD=ATEND,DDNAME=TEACHERS,          X
               RECFM=FB,LRECL=80,BLKSIZE=0               
        YREGS ,
        END   SEQA3              define main entry point
/*
//GO.SYSPRINT DD SYSOUT=*
//TEACHERS DD DSN=HERC01.TEST.SEQDATA(TEACHER),DISP=SHR
//
