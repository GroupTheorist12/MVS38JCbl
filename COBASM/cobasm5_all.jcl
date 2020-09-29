//HEHI5 JOB (COBOL), 
//             'Asm HI5',
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
//SYSIN  DD *
       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'MAIN'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
         01 WAGE-OUT          PIC ZZZZZZ9.99- USAGE DISPLAY.

         01 COMMON-DATA       USAGE COMP-3.                 
            05 HOURS          PIC S99V9       VALUE +12.5.
            05 RATE           PIC S999V99     VALUE +11.75.
            05 WAGE           PIC S9(7)V99.

       PROCEDURE DIVISION.

           MOVE RATE TO WAGE.
           CALL 'PROG13D' USING COMMON-DATA.
           MOVE WAGE TO WAGE-OUT.
           DISPLAY 'AMOUNT OF WAGE ' WAGE-OUT.

           STOP RUN.
/*
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
//SYSIN     DD * 
         PRINT ON,NOGEN 
DATAB    DSECT
HRSPK    DS     PL2
RATEPK   DS     PL3
WAGEPK   DS     PL5

PROG13D  CSECT
         SAVE   (14,12)
         BALR   9,0
         USING  *,9
         USING  DATAB,4      
         L      4,0(1)

         ST     13,SAVEB+4
         LR     12,13
         LA     13,SAVEB
         ST     13,8(12)    
         MP     WAGEPK,HRSPK
         SRP    WAGEPK,63,5

         OPEN  (TEACHERS,INPUT)   open TEACHERS
LOOP     GET   TEACHERS,IREC      Read a single teacher record
         MVC   WTOTEXT(27),IREC
         WTO   MF=(E,WTOBLOCK)
         B     LOOP               Repeat

ATEND    CLOSE TEACHERS

         L      13,SAVEB+4
         RETURN (14,12) 


SAVER1   DC    F'0'
IREC     DS    0CL80              Teacher record     
ITID     DS    CL3                Teacher ID nbr
ITNAME   DS    CL15               Teacher name
ITDEG    DS    CL4                Highest degree
ITTEN    DS    CL1                Tenured?
ITPHONE  DS    CL4                Phone nbr
FILL     DS    CL53               Fill   

WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '

SPACE8   DC    CL8' '
ZERO     DS    F


TEACHERS DCB   DSORG=PS,MACRF=GM,EODAD=ATEND,DDNAME=TEACHERS,          X
               RECFM=FBA,LRECL=80,BLKSIZE=0               

SAVEB    DS     18F                
         END    PROG13D
/*
//LKED     EXEC PGM=IEWL,
//             COND=(5,LT,COB),
//             PARM='LIST,MAP,XREF,LET,RENT'
//SYSPRINT  DD SYSOUT=*
//SYSLMOD   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSLIB DD   DSNAME=SYS1.COBLIB,DISP=SHR                          
//SYSUT1    DD UNIT=SYSDA,SPACE=(TRK,(5,5))
//SYSLIN    DD DSN=&&OBJ,DISP=(OLD,DELETE)
//          DD *
 NAME COBASM5(R)
//*-------------------------------------------------------------------
//COBASM5    EXEC PGM=COBASM5
//STEPLIB   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//TEACHERS DD DSN=HERC01.TEST.SEQDATA(TEACHER),DISP=SHR
//