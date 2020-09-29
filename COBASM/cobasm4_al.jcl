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
      *****************************************************************
      *    DATA-STRUCTURE FOR TITLE AND COPYRIGHT...
      *    HTTP://WWW.SIMOTIME.COM/QSAMIO01.HTM#SIMILARPOINTS
      *    ------------------------------------------------------------
       01  SIM-TITLE.
           05  T1 PIC X(11) VALUE '* QSAMIOC1 '.
           05  T2 PIC X(34) VALUE 'COBOL CALLS ASSEMBLER QSAM I/O    '.
           05  T3 PIC X(10) VALUE ' V03.01.24'.
           05  T4 PIC X(24) VALUE ' HTTP://WWW.SIMOTIME.COM'.
       01  SIM-COPYRIGHT.
           05  C1 PIC X(11) VALUE '* QSAMIOC1 '.
           05  C2 PIC X(20) VALUE 'COPYRIGHT 1987-2019 '.
           05  C3 PIC X(28) VALUE '   SIMOTIME TECHNOLOGIES    '.
           05  C4 PIC X(20) VALUE ' ALL RIGHTS RESERVED'.

       01  SIM-THANKS-01.
           05  C1 PIC X(11) VALUE '* QSAMIOC1 '.
           05  C2 PIC X(32) VALUE 'THANK YOU FOR USING THIS PROGRAM'.
           05  C3 PIC X(32) VALUE ' PROVIDED FROM SIMOTIME TECHNOLO'.
           05  C4 PIC X(04) VALUE 'GIES'.

       01  SIM-THANKS-02.
           05  C1 PIC X(11) VALUE '* QSAMIOC1 '.
           05  C2 PIC X(32) VALUE 'PLEASE SEND ALL INQUIRES OR SUGG'.
           05  C3 PIC X(32) VALUE 'ESTIONS TO THE HELPDESK@SIMOTIME'.
           05  C4 PIC X(04) VALUE '.COM'.

       01  RECORD-SIZE-LIMIT           PIC 9(5)    VALUE 4096.

       01  REQUEST-OPEN                PIC X(8)    VALUE 'OPEN    '.
       01  REQUEST-GET                 PIC X(8)    VALUE 'GET     '.
       01  REQUEST-CLOSE               PIC X(8)    VALUE 'CLOSE   '.

       01  END-OF-FILE                 PIC X(3)    VALUE 'NO '.

       01  OPERATOR-MESSAGE            PIC X(48).

       01  PASS-AREA.
           05  PASS-REQUEST            PIC X(8).
           05  PASS-RESULT             PIC S9(9)   COMP.
               88  NORMAL-RESULT       VALUE +0.
               88  COBOL-RESULT-SAME   VALUE +8.
               88  EOF-RESULT          VALUE +16.
           05  PASS-LRECL              PIC S9(4)   COMP.
           05  PASS-DATA               PIC X(4096).
      *****************************************************************
       PROCEDURE DIVISION.

   
           DISPLAY '* QSAMIOC1 OPEN REQUEST...'  UPON CONSOLE.
           PERFORM OPEN-THE-FILE.
   
           MOVE REQUEST-GET TO PASS-REQUEST.

           PERFORM GET-NEXT-RECORD. 
           
           PERFORM CLOSE-THE-FILE.
           DISPLAY '* QSAMIOC1 HAS COMPLETED...' UPON CONSOLE.

   
           GOBACK.

      *****************************************************************
   
       OPEN-THE-FILE.
           ADD 8 ZERO GIVING PASS-RESULT
           MOVE REQUEST-OPEN TO PASS-REQUEST
           CALL 'QSAMIOA1' USING PASS-AREA.
   
       CLOSE-THE-FILE.
           ADD 8 ZERO GIVING PASS-RESULT
           MOVE REQUEST-CLOSE TO PASS-REQUEST
           CALL 'QSAMIOA1' USING PASS-AREA.
   
       GET-NEXT-RECORD.
           CALL 'QSAMIOA1' USING PASS-AREA
           IF  EOF-RESULT
             MOVE 'YES' TO END-OF-FILE
           ELSE
             DISPLAY PASS-DATA UPON CONSOLE.   
         
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
QSAMIOA1 CSECT

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
***********************************************************************
         SAVE  (14,12)
         BALR  12,0
         USING *,12
*
         ST    R1,SAVER1           * Save Register 1
         L     R8,0(,R1)           * Get address of PASS-AREA
*
         CLC   0(8,R8),GET         * Is this an GET request...
         BE    GETRTN

         CLC   0(8,R8),OPEN        * Is this an OPEN request...
         BE    OPENRTN
*
         CLC   0(8,R8),CLOSE       * Is this an CLOSE request...
         BE    CLOSERTN
*
         LA    R15,15              * Set return-code to 15
         B     RETURN                Return to Calling program
*
***********************************************************************
OPENRTN  EQU   *
         OPEN  (TEACHERS,(INPUT))
         LTR   R15,R15             * Was OPEN successful ???
         BNZ   BADOPEN               If not, then quit
         ST    R15,8(,R8)          * Set Return Field in Pass Area
         LA    R9,TEACHERS         * Get Address of DCB using Reg-9
         MVC   12(2,R8),82(R9)     * Get Record length from DCB         
         WTO   '* QSAMIOA1, QSAMFILE - OPENED'
         B     RETURN              * Return to Calling program
*
GETRTN   EQU   *
         L     R1,SAVER1
         L     R3,0(R1)
         LA    R3,14(,R3)          * Get address of COBOL data buffer
         GET   TEACHERS,(R3)
         LTR   R15,R15             * Is RETURN-CODE = 0 ???
         BNZ   BADGET                If not, then post a message
         ST    R15,8(,R8)            Set user RETURN-CODE to ZERO
         LA    R9,TEACHERS         * Get Address of DCB using Reg-9
         MVC   12(2,R8),82(R9)     * Get Record length from DCB
         WTO   '* QSAMIOA1, QSAMFILE - GET'
         B     RETURN

CLOSERTN EQU   *
         CLOSE (TEACHERS)
         WTO   '* QSAMIOA1, QSAMFILE - CLOSED'
         ST    R15,8(,R8)          * Set user RETURN-CODE...
*
***********************************************************************
RETURN   EQU   *
         SR    15,15               * Set user RETURN CODE to ZERO
         RETURN (14,12),RC=(15)
*
ERROR1   EQU   *
         WTO   '* QSAMIOA1, QSAMFILE - I/O ERROR'
         RETURN (14,12),,RC=1
*
BADOPEN  EQU   *
         ST    R15,8(,R8)          * Set user RETURN-CODE...
         WTO   '* QSAMIOA1 THE FILE OPEN FAILED...'
         L     R15,8(,R8)
         RETURN (14,12),RC=(15)
*
BADGET   EQU   *
         ST    R15,8(,R8)          * Set user RETURN-CODE...
         WTO   '* QSAMIOA1 THE FILE GET FAILED...'
         L     R15,8(,R8)
         RETURN (14,12),RC=(15)
*
EODRTN   EQU   *
         WTO   '* QSAMIOA1 THE END-OF-FILE HAS BEEN PROCESSED'
         LA    R15,16
         ST    R15,8(,R8)          * Set user RETURN-CODE...
         RETURN (14,12),RC=(15)


SAVER1   DC    F'0'
GET      DC    CL8'GET     '
OPEN     DC    CL8'OPEN    '
CLOSE    DC    CL8'CLOSE   '

TEACHERS DCB   DSORG=PS,MACRF=GM,EODAD=EODRTN,DDNAME=TEACHERS
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
 NAME COBASM4(R)
//*-------------------------------------------------------------------
//COBASM4    EXEC PGM=COBASM4
//STEPLIB   DD DSN=HERC01.CODE.LOADLIB,DISP=SHR
//SYSPRINT DD SYSOUT=*
//SYSOUT DD SYSOUT=* 
//TEACHERS DD DSN=HERC01.TEST.SEQDATA(TEACHER),DISP=SHR
//