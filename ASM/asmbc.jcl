//HEAAA JOB (COBOL), 
//             'Assemble',
//             CLASS=A,
//             MSGCLASS=A,
//             REGION=8M,TIME=1440,
//             MSGLEVEL=(1,1),
//  USER=HERC01,PASSWORD=CUL8TR
//IEBGENER EXEC PGM=IEBGENER,REGION=128K
//SYSIN    DD  DUMMY
//SYSPRINT DD  SYSOUT=A
//SYSUT1   DD  *
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
*
         LTR   R1,R1
         BZ    NOPARMS
*
         LR    R2,R1           * Put addr of addr list into reg-2
*
         WTO   '* ASMASMAA is starting...'
*
         LA    R3,TOOMANY      * Limit loop count to reg-3 value
         LA    R4,4            * Set reg-4 to four (Loop Limit)
*
ADDRLOOP EQU   *
         L     R5,0(,R2)       * Use reg-5 for WTO address
         WTO   MF=(E,(R5))
         TM    0(R2),X'80'     * Is this last parameter...
         BO    EOJAOK          * If yes, Branch out of loop...
         LA    R2,4(,R2)               increment to next addr in list
         BCT   R4,ADDRLOOP       Else, decrement parameter count
         B     TOOMANY         * Too-many or invalid parm list
*
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
         RETURN (14,12),RC=4
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
         DS    0F            + Force alignment
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
//SYSUT2   DD DSN=HERC01.CODE.ASM(ASMASMAA),DISP=OLD
//SYSIN    DD DUMMY
//
