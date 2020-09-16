//HEAAB JOB (COBOL), 
//             'Assemble B',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//IEBGENER EXEC PGM=IEBGENER,REGION=128K
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  *
ASMASMA1 CSECT
***********************************************************************
*             ASMASMA1.MLC - This is an HLASM Program                 *
*                 Provided by SimoTime Technologies                   *
*           (C) Copyright 1987-2019 All Rights Reserved               *
*              Web Site URL:   http://www.simotime.com                *
*                    e-mail:   helpdesk@simotime.com                  *
***********************************************************************
*                                                                     *
* Created: 1988/06/01, Simmons                                        *
* Changed: 1990/03/01, Simmons, migrate to Micro Focus                *
*                                                                     *
***********************************************************************
*                                                                     *
* This program will run on an IBM Mainframe using MVS or a PC using   *
* Micro Focus Mainframe Express, version 2.5 or later (MFE) with      *
* the Assembler Option.                                               *
*                                                                     *
* This program provides an example of an assembler program using the  *
* call macro to pass control to another assembler program.            *
*                                                                     *
* Using the Micro Focus Animation you can immediately see the results *
* of each instruction execution. This is a very effective way to      *
* become familiar with how these techniques work.                     *
*                                                                     *
***********************************************************************
* This program provides an example of the CALL macro.                 *
***********************************************************************
*
*        AMODE 31
         SAVE  (14,12)
         BALR  12,0              PREPARE A BASE REGISTER
         USING *,12              ESTABLISH BASE REGISTER
         ST    R13,SAVREG13
*
         WTO   '* ASMASMA1 is starting, example of CALL macro...'
*
*---------------------------------------------------------------------*
* The following routine is an example of calling another program using
* the CALL macro. The following will not pass parameters. Since the
* CALLed program test for this condition a message will be displayed.
* Standard member-to-member linkage is used. The CALL macro will
* generate the code to pass control to the CALLed program. The CALLed
* program should return to the next line a code in this program.
*
         WTO   '* ASMASMA1 calling ASMASMAA without parameters...'
         LA    R13,SAVEAREA
         SR    R1,R1
         CALL  ASMASMAA
         WTO   '* ASMASMA1 return...'
*
*---------------------------------------------------------------------*
* The following routine is an example of calling another program using
* the CALL macro. The following will pass parameters. Parameters are
* passed via an address list.
* Standard member-to-member linkage is used.
* The CALL macro will generate the code to pass control to the CALLed
* program. The CALLed program should return to the next line a code
* in this program.
*
         WTO   '* ASMASMA1 calling ASMASMAA with four parameters...'
         LA    R13,SAVEAREA
         CALL  ASMASMAA,(PARM01,PARM02,PARM03,PARM04),VL
         WTO   '* ASMASMA1 return...'
*
*---------------------------------------------------------------------*
EOJAOK   EQU   *
         WTO   '* ASMASMA1 is complete, example of CALL macro......'
         L     R13,SAVREG13
         RETURN (14,12),RC=0
*
***********************************************************************
* ABENDING WITH RETURN-CODE OF 8
* RETURN to the CALLING PROGRAM OR OPERATING SYSTEM
*
ABEND08  EQU   *
         WTO   '* ASMASMA1 is abending...RC=0008'
         L     R13,SAVREG13
         RETURN (14,12),RC=8
*
***********************************************************************
* Define Constants and EQUates
*
         DS    0F            + Force alignment
*
SAVEAREA EQU   *
         DC    A(0)
         DC    A(0)
SAVREG13 DC    A(0)
         DC    15A(0)        * Used by SAVE/RETURN functions
*
PARM01   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 01 '
PARM02   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 02 '
PARM03   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 03 '
PARM04   DC    Y(28),Y(0),CL24'* ASMASMA1 parameter 04 '
*
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
//SYSUT2   DD DSN=HERC01.CODE.ASM(ASMASMA1),DISP=OLD
//SYSIN    DD DUMMY
//
