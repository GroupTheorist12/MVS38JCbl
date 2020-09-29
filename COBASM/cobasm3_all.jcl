//HEHI3 JOB (COBOL), 
//             'Asm HI3',
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
         01  WS-MODULE-BLK-1.                                             
             05  WS-MODULE-NAME1     PIC X(8)   VALUE 'TESTDYN1'.         
             05  WS-MODULE-ADDR      PIC X(4)   VALUE LOW-VALUES.         
             05  WS-CALL-MODE1       PIC X      VALUE 'K'.                
             05  FILLER              PIC XXX    VALUE LOW-VALUES.         
       PROCEDURE DIVISION.
           CALL 'ASMASMAA'.
           DISPLAY 'RETURNED FROM CALL'.
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
ASMASMAA CSECT
***********************************************************************
*             ASMASMAA.MLC - This is an HLASM Program                 *
*                 Provided by SimoTime Technologies                   *
*           (C) Copyright 1987-2019 All Rights Reserved               *
*              Web Site URL:   http://www.simotime.com                *
*                    e-mail:   helpdesk@simotime.com                  *
***********************************************************************
*                                                                     *
* Created: 1988/06/01, Simmons                                        *
* Changed: 1993/03/01, Simmons, Migrate to Micro Focus                *
*                                                                     *
***********************************************************************
*                                                                     *
* This program will run on an IBM Mainframe using MVS or a PC using   *
* Micro Focus Mainframe Express, version 2.5 or later (MFE) with      *
* the Assembler Option.                                               *
*                                                                     *
* This program provides an example of an assembler program that       *
* receives control from another program via a call, load or link.     *
*                                                                     *
* Using the Micro Focus Animation you can immediately see the results *
* of each instruction execution. This is a very effective way to      *
* become familiar with how these techniques work.                     *
*                                                                     *
***********************************************************************
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
         ST    R1,SAVER1           * Save Register 1

*
         LTR   R1,R1
         BZ    NOPARMS
*
         LR    R2,R1           * Put addr of addr list into reg-2
*
PARMFND  DS    0H                                                       
         L     R3,0(,R2)           GET ADDR OF PROGRAM NAME             
         MVC   PGMBLK,0(R3)        GET PGMBLK - NAME, ADDR, FUNC        
         WTO   'Loaded parms'
         CLI   PGMFUNC,C'K'                                   
         BE    KKK

NKKK     DS 0H
         WTO   'Loaded parms and NOT K'    

KKK     DS 0H
         WTO   'Load file'    

         WTO   'Loaded parms and K'    
         MVC   WTOTEXT(8),PGM
         WTO   MF=(E,WTOBLOCK)
         MVC   PGMADDR,IPFX
         MVC   0(L'PGMBLK,R3),PGMBLK


*---------------------------------------------------------------------*

* NORMAL END-OF-JOB
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
EOJAOK   EQU   *
         WTO   '* ASMASMAA is returning...'
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* ASMASMAA is abending...RC=0008'
         RETURN (14,12),RC=8
*
***********************************************************************
* Post a non-paramter message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
NOPARMS  EQU   *
         WTO   '* ASMASMAA called with zero parameters'
         OPEN  (TEACHERS,INPUT)   open TEACHERS
LOOP     GET   TEACHERS,IREC      Read a single teacher record
         MVC   WTOTEXT(27),IREC
         WTO   MF=(E,WTOBLOCK)
         B     LOOP               Repeat

ATEND    CLOSE TEACHERS
         B     EOJAOK  
*         RETURN (14,12),RC=4
*
***********************************************************************
* Post a too-many-paramters message...
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
TOOMANY  EQU   *
         WTO   '* ASMASMAA called with too many parameters'
         RETURN (14,12),RC=4
*
***********************************************************************
* Define Constants and EQUates
*
SAVER1   DC    F'0'
IREC     DS    0CL80              Teacher record     
ITID     DS    CL3                Teacher ID nbr
ITNAME   DS    CL15               Teacher name
ITDEG    DS    CL4                Highest degree
ITTEN    DS    CL1                Tenured?
ITPHONE  DS    CL4                Phone nbr
FILL     DS    CL53               Fill   

         DS    0F            + Force alignment
IPFX     DC    CL4'BRAD'
PGMBLK   DS    0CL16                                                    
PGM      DC    CL8' '                                                   
PGMADDR  DC    F'0'                                                     
PGMFUNC  DC    C' '                                                     
         DS    CL3    

WTOBLOCK EQU   *
         DC    H'80'         
         DC    H'0'                     
WTOTEXT  DC    CL76' '

SPACE8   DC    CL8' '
ZERO     DS    F


TEACHERS DCB   DSORG=PS,MACRF=GM,EODAD=ATEND,DDNAME=TEACHERS,          X
               RECFM=FBA,LRECL=80,BLKSIZE=0               


* Register EQUates
*
R0       EQU   0
R1       EQU   1
R2       EQU   2
R3       EQU   3
R4       EQU   4
R5       EQU   5
R6       EQU   6
R7       EQU   7
R8       EQU   8
R9       EQU   9
R10      EQU   10
R11      EQU   11
R12      EQU   12
R13      EQU   13
R14      EQU   14
R15      EQU   15
*
         END
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
 NAME COBASM3(R)
//*-------------------------------------------------------------------
//COBASM2    EXEC PGM=COBASM3
//STEPLIB   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//TEACHERS DD DSN=HERC01.TEST.SEQDATA(TEACHER),DISP=SHR
//