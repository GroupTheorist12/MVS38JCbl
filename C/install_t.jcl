//HERC01I JOB MSGCLASS=A,MSGLEVEL=(1,1),NOTIFY=HERC01,                  00000010
//             USER=HERC01,PASSWORD=CUL8TR                              00000011  
//*                                                                     00000020
//*   INSTALL THE DYNALOAD SUBROUTINE AND TEST MODULES                  00000030
//*                                                                     00000040
//*  FIRST - DELETE ANY EXISTING PDS FILES                              00000050
//*                                                                     00000060
//IDCAMS  EXEC PGM=IDCAMS                                               00000070
//SYSPRINT DD SYSOUT=*                                                  00000080
//SYSIN    DD *                                                         00000090
 DELETE 'HERC01.CODE.ASM' NONVSAM PURGE                                 00000100
 DELETE 'HERC01.CODE.SOURCE' NONVSAM PURGE                              00000110
 DELETE 'HERC01.CODE.LOADLIB' NONVSAM PURGE                             00000120
 SET MAXCC = 0                                                          00000130
//*                                                                     00000140
//*   NOW - CREATE THE PDS FOR THE ASM SOURCE CODE                      00000150
//*                                                                     00000160
//STEP1   EXEC PGM=IEBUPDTE,PARM=NEW,COND=(0,NE)                        00000170
//SYSUT2   DD DSN=HERC01.CODE.ASM,DISP=(NEW,CATLG,DELETE),              00000180
//         UNIT=DISK,SPACE=(TRK,(1,1,1)),VOL=SER=PUB012,                00000190
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120,DSORG=PO)                00000200
//SYSPRINT DD SYSOUT=*                                                  00000210
//SYSIN    DD *                                                         00000220
./   ADD NAME=DYNALOAD,LIST=ALL,SEQFLD=738                              00000230
./  NUMBER NEW1=10,INCR=10                                              00000240
*                                                                     * 00000250
         PRINT ON,GEN,NODATA                                            00000260
*---------------------------------------------------------------------* 00000270
*                                                                     * 00000280
* THIS ROUTINE IS DESIGNED TO PROVIDE DYNAMIC PROGRAM LOADING         * 00000290
* FOR PROGRAMS COMPILED WITH COMPILERS THAT ONLY SUPPORT STATIC       * 00000300
* CALLS.  MVT COBOL IS AN EXAMPLE OF THIS.                            * 00000310
*                                                                     * 00000320
* EXAMPLE:   IN MVT COBOL,                                            * 00000330
*      CALL 'PROGRAMA' USING PARM-1 PARM-2.                           * 00000340
* IT IS NECESSARY TO LINK THE OBJECT MODULE FOR THE PROGRAMA          * 00000350
* ROUTINE TO EACH CALLING COBOL PROGRAM.  THE PROGRAM CODE AND        * 00000360
* WORKING STORAGE ARE PRESERVED BETWEEN CALLS.                        * 00000370
*                                                                     * 00000380
* IN MVS COBOL, THE STATIC CALL WILL FUNCTION THE SAME WAY.  AN       * 00000390
* EXTENSTION TO COBOL ALLOWS FOR DYNAMIC CALLS TO SUBROUTINES.        * 00000400
*                                                                     * 00000410
*     WORKING-STORAGE SECTION.                                        * 00000420
*     ...                                                             * 00000430
*         05  WS-PGM-NAME        PIC X(8)  VALUE SPACES.              * 00000440
*     ...                                                             * 00000450
*      ...                                                            * 00000460
*      PROCEDURE DIVISION.                                            * 00000470
*      ...                                                            * 00000480
*      MOVE 'PROGRAMA' TO WS-PGM-NAME.                                * 00000490
*      CALL WS-PGM-NAME USING PARM-1 PARM-2.                          * 00000500
*                                                                     * 00000510
* THIS CALL RESULTS IN 'PROGRAMA' BEING LOADED AT RUN TIME INTO       * 00000520
* MEMORY AND THEN CALLED.   EACH TIME A MODULE IS DYNAMICALLY CALLED, * 00000530
* MVS CHECKS TO SEE IF THE LOAD MODULE IS RENTRANT OR RESUABLE.  IF   * 00000540
* SO, THE COPY OF THE PROGRAM IN MEMORY IS REUSED.  IF NOT, A NEW     * 00000550
* COPY IF THE PROGRAM IS LOADED FROM DISK AND CALLED.                 * 00000560
*                                                                     * 00000570
* THE MVS COBOL DYNAMIC CALL CAN BE SIMULATED IN MVT COBOL BY         * 00000580
* CALLING AN ASSEMBLER PROGRAM WHICH WILL LOAD THE SUBROUTINE AND     * 00000590
* PASS THE OPTIONAL PARAMETERS.                                       * 00000600
*                                                                     * 00000610
* EXAMPLE:                                                            * 00000620
*     WORKING-STORAGE SECTION.                                        * 00000630
*     01  WS-PGM-BLK.                                                 * 00000640
*         05  WS-PGM-NAME        PIC X(8)  VALUE SPACES.              * 00000650
*         05  WS-PGM-ADDR        PIC X(4)  VALUE LOW-VALUES.          * 00000660
*         05  WS-CALL-MODE       PIC X     VALUE 'K'.                 * 00000670
*         05  FILLER             PIC X(3)  VALUE LOW-VALUES.          * 00000680
*      ...                                                            * 00000690
*      PROCEDURE DIVISION.                                            * 00000700
*      ...                                                            * 00000710
*                                                                     * 00000720
*      MOVE 'PROGRAMA' TO WS-PGM-NAME.                                * 00000730
*      CALL 'DYNALOAD' USING WS-PGM-BLK  PARM-1 PARM-2.               * 00000740
*                                                                     * 00000750
*                                                                     * 00000760
*  NOTES:                                                             * 00000770
*    - THE WS-PGM-ADDR FIELD MUST BE INITIALIZED TO LOW-VALUES        * 00000780
*      BEFORE THE FIRST CALL.  DO NOT CHANGE THE VALUE OF             * 00000790
*      THIS FIELD.  IF IT IS NOT LOW-VALUES, DYNALOAD ASSUMES         * 00000800
*      THIS IS THE ADDRESS IN MEMORY OF PROGRAMA.                     * 00000810
*                                                                     * 00000820
*    - THE WS-CALL-MODE  MUST BE 'K' OR 'R'.                          * 00000830
*        K INDICATES KEEP THE WORKING STORAGE AND MODULE FROM         * 00000840
*          LAST CALL.  IF WS-PGM-ADDR IS NOT LOW-VALUES, THIS         * 00000850
*          ADDRESS IS CALLED.                                         * 00000860
*                                                                     * 00000870
*        R INDICATE REFRESH MODULE FROM DISK, THUS CLEARING           * 00000880
*          WORKING STORAGE BACK TO THE INITIAL VALUES.                * 00000890
*                                                                     * 00000900
*       YOU MAY DEFINE AND USE AS MANY WS-PGM-BLK AS NEEDED.          * 00000910
*                                                                     * 00000920
* IT IS NECESSARY TO LINK THE OBJECT MODULE FOR THE DYNALOAD          * 00000930
* ROUTINE TO EACH CALLING PROGRAM. IT IS ALSO NECESSARY TO LINK       * 00000940
* THE PROGRAMA AS AN EXECUTABLE MODULE.  THE BENEFIT OF THIS IS THE   * 00000950
* MODULE IS NOT STATIC LINKED INTO ALL MODULES WHICH CALL IT.         * 00000960
* IF THE ROUTINE IS CHANGED, AS LONG AS THE PARM FORMATS ARE          * 00000970
* THE SAME, THE CALLING MODULES WILL NOT NEED TO BE CHANGED.          * 00000980
*                                                                     * 00000990
* FOR EXAMPLE, AN MVT COBOL APPLICATION CONSISTS OF 100 PROGRAMS,     * 00001000
* EACH OF WHICH CALL AN IO MODULE CALLED IOMOD.  USING STATIC CALLS,  * 00001010
* A COPY OF IOMOD IS LINK EDITED INTO EACH OF THE 100 LOAD MODULES.   * 00001020
* MAKING A CHANGE TO IOMOD WOULD REQUIRE 100 LOAD MODULES TO BE       * 00001030
* RELINKED.  USING DYNALOAD, ONLY IOMOD WOULD NEED TO BE RELINKED.    * 00001040
* THE 100 CALLING MODULES WOULD ONLY NEED TO BE TESTED.               * 00001050
*                                                                     * 00001060
* I HAVE USED THIS ROUTINE SINCE THE 1970'S.  IT WILL WORK WITH       * 00001070
* MVS COBOL BUT IT COULD CONFUSE DEBUGGERS.                           * 00001080
*                                                                     * 00001090
* THIS CODE IS PLACED IN THE PUBLIC DOMAIN AND MAY BE FREELY USED     * 00001100
* AND INCORPORATED INTO DERIVED WORKS AS LONG AS ATTRIBUTION TO THE   * 00001110
* ORIGINAL AUTHORSHIP REMAINS IN ANY DISTRIBUTED COPIES OF THE ALC    * 00001120
* SOURCE.                                                             * 00001130
*                                                                     * 00001140
* REWRITTEN DECEMBER, 2006 BY ED LISS                                 * 00001150
* HTTP://WWW.SUMMERMOON.COM/HERCULES/                                 * 00001160
*                                                                     * 00001170
*---------------------------------------------------------------------* 00001180
         EJECT                                                          00001190
*                                                                       00001200
         LCLC  &SYSECT                                                  00001210
&SYSECT  SETC  'DYNALOAD'          ROUTINE IDENTIFICATION               00001220
*                                                                       00001230
&SYSECT  CSECT                                                          00001240
*                                                                       00001250
@IDENT01 B     @IDENT04(R15)       BRANCH AROUND IDENT CONSTANTS        00001260
         DC    AL1(@IDENT03-@IDENT02)                                   00001270
@IDENT02 DC    C'&SYSECT V1'                                            00001280
         DC    C'&SYSDATE &SYSTIME - '                                  00001290
         DC    C'DYNAMIC LOAD ROUTINE FOR MVT COBOL'                    00001300
@IDENT03 DS    0H                                                       00001310
@IDENT04 EQU   *-@IDENT01                                               00001320
*                                                                       00001330
         SAVE  (14,12)                                                  00001340
*                                                                       00001350
         BALR  R12,0               BASE REGISTERS ARE 12                00001360
         USING *,R12                                                    00001370
*                                                                       00001380
         LR    R5,R13              COPY CALLER'S SAVEAREA ADDR          00001390
         LA    R13,SAVEAREA        ESTABLISH MY SAVEAREA                00001400
         ST    R5,4(,R13)          BACK CHAIN SAVE AREAS                00001410
         ST    R13,8(,R5)          FORWARD CHAIN SAVE AREAS             00001420
*                                                                       00001430
 00001440
* AT LEAST ONE PARM MUST BE PASSED.  THIS IS THE NAME OF THE LOAD     * 00001450
* MODULE TO DYNAMICALY CALL.  IF THIS IS MISSING, THE MODULE WILL     * 00001460
* ABORT WITH A U0001 ABEND CODE.                                      * 00001470
* THIS MODULE WILL STRIP OFF THE PROGRAM NAME AND PASS THE REMAINING  * 00001480
* PARMS, IF ANY, TO THE SUBROUTINE BEING CALLED.                      * 00001490
* IF THERE ARE NO PARMS TO PASS, R1 IS SET TO ZEROS.                  * 00001500
*---------------------------------------------------------------------* 00001510
         LTR   R1,R1                                                    00001520
         BNZ   PARMFND             BRANCH IF PARM LIST PRESENT          00001530
         ABEND 1,,,USER                                                 00001540
PARMFND  DS    0H                                                       00001550
         LR    R2,R1               COPY PARMLIST ADDR TO R2             00001560
         L     R3,0(,R2)           GET ADDR OF PROGRAM NAME             00001570
         MVC   PGMBLK,0(R3)        GET PGMBLK - NAME, ADDR, FUNC        00001580
         TM    0(R2),X'80'         CHECK FOR LAST PARM                  00001590
         BZ    OPTPARMS            MORE PARMS FOUND                     00001600
         SR    R4,R4               SET PARM ADDR TO ZERO                00001610
         B     DYNACALL                                                 00001620
OPTPARMS DS    0H                                                       00001630
         LA    R4,4(,R2)           ADVANCE TO NEXT PARM                 00001640
DYNACALL DS    0H                                                       00001650
         L     R0,PGMADDR          GET ADDR IN MEMORY                   00001660
         CLC   PGMADDR,=4X'00'     IS IS ZEROS                          00001670
         BE    DOLOAD                                                   00001680
         CLI   PGMFUNC,C'K'        KEEP CALL?                           00001690
         BE    SKIPLOAD                                                 00001700
         CLI   PGMFUNC,C'R'                                             00001710
         BE    DOLOAD                                                   00001720
         ABEND 2,,,USER            ABORT IF NO CORRECT PARM             00001730
*                                                                       00001740
DOLOAD   DS    0H                                                       00001750
         LOAD  EPLOC=PGM                                                00001760
         ST    R0,PGMADDR                                               00001770
SKIPLOAD DS    0H                                                       00001780
         MVC   0(L'PGMBLK,R3),PGMBLK PUT CTL BLK BACK IN CALLERS WS     00001790
         LR    R1,R4               PUT PARMLIST IN R1                   00001800
         LR    R15,R0              COPY MODULE ADDR TO R15              00001810
         BALR  R14,R15             CALL LOADED PGM                      00001820
GOBACK   DS    0H                                                       00001830
*---------------------------------------------------------------------* 00001840
* RETURN TO CALLING PROGRAM WITH ZERO RETURN CODE IN R15              * 00001850
*---------------------------------------------------------------------* 00001860
         L     R13,4(,R13)    RESET TO CALLERS SAVE AREA                00001870
         RETURN (14,12),RC=0                                            00001880
*                                                                       00001890
         DS    0F                                                       00001900
PGMBLK   DS    0CL16                                                    00001910
PGM      DC    CL8' '                                                   00001920
PGMADDR  DC    F'0'                                                     00001930
PGMFUNC  DC    C' '                                                     00001940
         DS    CL3                                                      00001950
*                                                                       00001960
*---------------------------------------------------------------------* 00001970
* MY REGISTER SAVE AREA                                               * 00001980
*---------------------------------------------------------------------* 00001990
SAVEAREA DS    18F                                                      00002000
*                                                                       00002010
R0       EQU   0                                                        00002020
R1       EQU   1                                                        00002030
R2       EQU   2                                                        00002040
R3       EQU   3                                                        00002050
R4       EQU   4                                                        00002060
R5       EQU   5                                                        00002070
R6       EQU   6                                                        00002080
R7       EQU   7                                                        00002090
R8       EQU   8                                                        00002100
R9       EQU   9                                                        00002110
R10      EQU   10                                                       00002120
R11      EQU   11                                                       00002130
R12      EQU   12                                                       00002140
R13      EQU   13                                                       00002150
R14      EQU   14                                                       00002160
R15      EQU   15                                                       00002170
*                                                                       00002180
         END                                                            00002190
//*                                                                     00002200
//*  NOW - STRIP OFF THE SEQUENCE NUMBERS IN POSITIONS 73-80            00002210
//*  OF THE COBOL TEST CODE                                             00002220
//*                                                                     00002230
//STEP2   EXEC PGM=IEBGENER,COND=(0,NE)                                 00002240
//SYSUT2   DD DSN=&&COBOL,DISP=(NEW,PASS,DELETE),                       00002250
//         UNIT=SYSDA,SPACE=(TRK,(5,5)),                                00002260
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120)                         00002270
//SYSPRINT DD SYSOUT=*                                                  00002280
//SYSIN  DD *                                                           00002290
 GENERATE MAXFLDS=2,MAXLITS=10                                          00002300
 RECORD FIELD=(72,1,,1),FIELD=(8,'        ',,73)                        00002310
//SYSUT1   DD *                                                         00002320
./   ADD NAME=TESTDYNA,LIST=ALL,SEQFLD=016                              00002330
./  NUMBER NEW1=10,INCR=10                                              00002340
000010 ID DIVISION.                                                     00002350
000020 PROGRAM-ID.  TESTDYNA.                                           00002360
000030******************************************************************00002370
000040*                                                                 00002380
000050*  TESTDYNA - TEST DRIVER FOR THE DYNALOAD MODULE                 00002390
000060*        THIS MODULE TESTS/DEMONSTRATES THE DYNAMIC LOADING OF    00002400
000070*        SUBROUTINES.                                             00002410
000080*                                                                 00002420
000090******************************************************************00002430
000100 ENVIRONMENT DIVISION.                                            00002440
000110 DATA DIVISION.                                                   00002450
000120 WORKING-STORAGE SECTION.                                         00002460
000130 01  FILLER PIC X(32)  VALUE '***** START TESTDYNA WKSTG *****'.  00002470
000140 01  WS-MODULE-BLK-1.                                             00002480
000150     05  WS-MODULE-NAME1     PIC X(8)   VALUE 'TESTDYN1'.         00002490
000160     05  WS-MODULE-ADDR      PIC X(4)   VALUE LOW-VALUES.         00002500
000170     05  WS-CALL-MODE1       PIC X      VALUE 'K'.                00002510
000180     05  FILLER              PIC XXX    VALUE LOW-VALUES.         00002520
000190 01  WS-MODULE-BLK-2.                                             00002530
000200     05  WS-MODULE-NAME2     PIC X(8)   VALUE 'TESTDYN1'.         00002540
000210     05  WS-MODULE-ADDR      PIC X(4)   VALUE LOW-VALUES.         00002550
000220     05  WS-CALL-MODE2       PIC X      VALUE 'R'.                00002560
000230     05  FILLER              PIC XXX    VALUE LOW-VALUES.         00002570
000240 01  WS-PARM-1.                                                   00002580
000250     05  WS-COUNTER          PIC 9(5)   VALUE ZEROS.              00002590
000260     05  WS-SUB              PIC 9(5)   VALUE ZEROS.              00002600
000270 01  FILLER PIC X(32)  VALUE '****** END TESTDYNA WKSTG ******'.  00002610
000280 PROCEDURE DIVISION.                                              00002620
000290 START-HERE.                                                      00002630
000300     DISPLAY 'STARTING TESTDYNA WITH DEFAULT K MODE.'.            00002640
000310                                                                  00002650
000320     PERFORM DYNA-CALL   10 TIMES.                                00002660
000330     PERFORM DYNA-CALL-R 10 TIMES.                                00002670
000340 E-O-J.                                                           00002680
000350     DISPLAY 'TESTDYNA ENDING'.                                   00002690
000360                                                                  00002700
000370     MOVE ZERO TO RETURN-CODE.                                    00002710
000380     STOP RUN.                                                    00002720
000390                                                                  00002730
000400 DYNA-CALL.                                                       00002740
000410                                                                  00002750
000420     DISPLAY 'CALLING ' WS-MODULE-NAME1 ' USING ' WS-CALL-MODE1.  00002760
000430     CALL 'DYNALOAD' USING WS-MODULE-BLK-1                        00002770
000440                           WS-PARM-1.                             00002780
000450                                                                  00002790
000460     DISPLAY 'RETURNED FROM ' WS-MODULE-NAME1                     00002800
000470             ',WS-CALL-MODE = ' WS-CALL-MODE1                     00002810
000480             ',WS-COUNTER = ' WS-COUNTER                          00002820
000490             ',WS-SUB = ' WS-SUB.                                 00002830
000500                                                                  00002840
000510 DYNA-CALL-R.                                                     00002850
000520                                                                  00002860
000530     DISPLAY 'CALLING ' WS-MODULE-NAME2 ' USING ' WS-CALL-MODE2.  00002870
000540     CALL 'DYNALOAD' USING WS-MODULE-BLK-2                        00002880
000550                           WS-PARM-1.                             00002890
000560                                                                  00002900
000570     DISPLAY 'RETURNED FROM ' WS-MODULE-NAME2                     00002910
000580             ',WS-CALL-MODE = ' WS-CALL-MODE2                     00002920
000590             ',WS-COUNTER = ' WS-COUNTER                          00002930
000600             ',WS-SUB = ' WS-SUB.                                 00002940
./   ADD NAME=TESTDYN1,LIST=ALL,SEQFLD=016                              00002950
./  NUMBER NEW1=10,INCR=10                                              00002960
000010 ID DIVISION.                                                     00002970
000020 PROGRAM-ID.  TESTDYN1.                                           00002980
000030******************************************************************00002990
000040*                                                                 00003000
000050*  TESTDYN1 - TEST STUB FOR THE DYNALOAD MODULE                   00003010
000060*        THIS MODULE TESTS/DEMONSTRATES THE DYNAMIC LOADING OF    00003020
000070*        SUBROUTINES.                                             00003030
000080*                                                                 00003040
000090******************************************************************00003050
000100 ENVIRONMENT DIVISION.                                            00003060
000110 DATA DIVISION.                                                   00003070
000120 WORKING-STORAGE SECTION.                                         00003080
000130 01  WS-COUNTER              PIC 9(5)  VALUE ZERO.                00003090
000140 LINKAGE SECTION.                                                 00003100
000150 01  LS-PARM-1.                                                   00003110
000160     05  LS-COUNTER          PIC 9(5).                            00003120
000170     05  LS-SUB              PIC 9(5).                            00003130
000180 PROCEDURE DIVISION USING LS-PARM-1.                              00003140
000190 START-HERE.                                                      00003150
000200     DISPLAY 'STARTING TESTDYN1.'.                                00003160
000210     ADD 1 TO LS-COUNTER.                                         00003170
000220     ADD 1 TO WS-COUNTER.                                         00003180
000230     MOVE  WS-COUNTER   TO  LS-SUB.                               00003190
000240     DISPLAY 'RETURNING WS-COUNTER = ' LS-COUNTER                 00003200
000250             ',WS-SUB = ' LS-SUB.                                 00003210
000260     MOVE ZERO TO RETURN-CODE.                                    00003220
000270     GOBACK.                                                      00003230
//*                                                                     00003240
//*  NOW - ADD THE COBOL TEST MODULES TO A PDS                          00003250
//*                                                                     00003260
//STEP3   EXEC PGM=IEBUPDTE,PARM=NEW,COND=(0,NE)                        00003270
//SYSUT2   DD DSN=HERC01.CODE.SOURCE,DISP=(NEW,CATLG,DELETE),           00003280
//         UNIT=DISK,SPACE=(TRK,(1,1,1)),VOL=SER=PUB012,                00003290
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=3120,DSORG=PO)                00003300
//SYSPRINT DD SYSOUT=*                                                  00003310
//SYSIN    DD DSN=&&COBOL,DISP=(OLD,PASS)                               00003320
//*                                                                     00003330
//*  NOW ASSEMBLE AND LINK THE DYNALOAD ROUTINE                         00003340
//*                                                                     00003350
//STEP4 EXEC ASMFCL,PARM.ASM='OBJ,NODECK'                               00003360
//ASM.SYSIN DD DSN=HERC01.CODE.ASM(DYNALOAD),DISP=SHR                   00003370
//LKED.SYSLMOD DD DSN=HERC01.CODE.LOADLIB(DYNALOAD),                    00003380
//         DISP=(NEW,CATLG,DELETE),                                     00003390
//         UNIT=DISK,VOL=SER=PUB012,                                    00003400
//         SPACE=(TRK,(2,2,2),RLSE),                                    00003410
//         DCB=(RECFM=U,BLKSIZE=19069,DSORG=PO)                         00003420
//*                                                                     00003430
//*  NOW COMPILE THE COBOL DRIVER ROUTINE                               00003440
//*                                                                     00003450
//STEP5 EXEC COBUCL                                                     00003460
//COB.SYSIN DD DSN=HERC01.CODE.SOURCE(TESTDYNA),DISP=SHR                00003470
//LKED.SYSLIB DD                                                        00003480
//        DD DSN=HERC01.CODE.LOADLIB,DISP=SHR                           00003490
//LKED.SYSLMOD DD DSN=HERC01.CODE.LOADLIB(TESTDYNA),DISP=SHR            00003500
//*                                                                     00003510
//*  NOW COMPILE THE COBOL TEST SUBROUTINE                              00003520
//*                                                                     00003530
//STEP6 EXEC COBUCL                                                     00003540
//COB.SYSIN DD DSN=HERC01.CODE.SOURCE(TESTDYN1),DISP=SHR                00003550
//LKED.SYSLMOD DD DSN=HERC01.CODE.LOADLIB(TESTDYN1),DISP=SHR            00003560
