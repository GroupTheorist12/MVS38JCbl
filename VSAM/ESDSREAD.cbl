000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ESDSREAD.
000300 AUTHOR. JAY MOSELEY.
000400 DATE-WRITTEN. NOVEMBER, 2001.
000500 DATE-COMPILED.
000600
000700* ************************************************************* *
000800* THIS PROGRAM TESTS THE VSAMIO ROUTINE BY READING RECORDS      *
000900* FROM AN ESDS CLUSTER AND DISPLAYING THEIR CONTENTS ON SYSOUT. *
001000* ************************************************************* *
001100
001200 ENVIRONMENT DIVISION.
001300 CONFIGURATION SECTION.
001400 SOURCE-COMPUTER. IBM-370.
001500 OBJECT-COMPUTER. IBM-370.
001600
001700 INPUT-OUTPUT SECTION.
001800 FILE-CONTROL.
001900
002000 DATA DIVISION.
002100 FILE SECTION.
002200
002300 WORKING-STORAGE SECTION.
002400 77  END-OF-FILE-SWITCH          PIC X(1)    VALUE 'N'.
002500     88  END-OF-FILE                         VALUE 'Y'.
002600
002700 77  RECORD-COUNTER              PIC S9(8)   VALUE +0.
002800 77  COUNTER-EDIT                PIC ZZ,ZZZ,ZZ9.
002900
003000 01  VSIO-PARAMETER-VALUES       COPY VSAMIO.
003100 01  ESDSF01                     COPY VSAMIOFB.
003200 01  ESDS-RECORD                 PIC X(80).
003300
003400 PROCEDURE DIVISION.
003500
003600 000-INITIATE.
003700
003800     DISPLAY 'ESDSREAD: READ ESDS SEQUENTIALLY'.
003900     DISPLAY '--------------------------------'.
004000     DISPLAY ' '.
004100
004200     MOVE 'ESDSF01' TO VSIO-DDNAME.
004300     MOVE VSIO-ESDS TO VSIO-ORGANIZATION.
004400     MOVE VSIO-SEQUENTIAL TO VSIO-ACCESS.
004500     MOVE VSIO-INPUT TO VSIO-MODE.
004600     MOVE +80 TO VSIO-RECORD-LENGTH.
004700     MOVE +0 TO VSIO-KEY-LENGTH, VSIO-KEY-POSITION.
004800     MOVE VSIO-OPEN TO VSIO-COMMAND.
004900     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, ESDSF01,
005000                         ESDS-RECORD.
005100*    END-CALL.
005200     IF NOT VSIO-SUCCESS
005300         DISPLAY 'VSAMIO ERROR OCCURRED DURING '
005400                 VSIO-COMMAND
005500         EXHIBIT NAMED VSIO-RETURN-CODE,
005600         EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
005700                       VSIO-VSAM-FUNCTION-CODE,
005800                       VSIO-VSAM-FEEDBACK-CODE
005900         STOP RUN.
006000*    END-IF.
006100
006200 010-PROCESS.
006300
006400     PERFORM 110-PROCESS-DATA
006500        THRU 119-EXIT
006600       UNTIL END-OF-FILE.
006700*    END-PERFORM.
006800
006900 020-TERMINATE.
007000
007100     MOVE VSIO-CLOSE TO VSIO-COMMAND.
007200     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, ESDSF01,
007300                         ESDS-RECORD.
007400*    END-CALL.
007500     IF NOT VSIO-SUCCESS
007600         DISPLAY 'VSAMIO ERROR OCCURRED DURING '
007700                 VSIO-COMMAND
007800         EXHIBIT NAMED VSIO-RETURN-CODE,
007900         EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
008000                       VSIO-VSAM-FUNCTION-CODE,
008100                       VSIO-VSAM-FEEDBACK-CODE.
008200*    END-IF.
008300
008400     STOP RUN.
008500
008600 110-PROCESS-DATA.
008700
008800     MOVE VSIO-READ TO VSIO-COMMAND.
008900     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, ESDSF01,
009000                         ESDS-RECORD.
009100*    END-CALL.
009200
009300     IF NOT VSIO-SUCCESS
009400         IF VSIO-END-OF-FILE
009500             MOVE 'Y' TO END-OF-FILE-SWITCH
009600         ELSE
009700             DISPLAY 'VSAMIO ERROR OCCURRED DURING '
009800                     VSIO-COMMAND
009900             EXHIBIT NAMED VSIO-RETURN-CODE,
010000             EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
010100                           VSIO-VSAM-FUNCTION-CODE,
010200                           VSIO-VSAM-FEEDBACK-CODE
010300             MOVE 'Y' TO END-OF-FILE-SWITCH.
010400*        END-IF
010500*    END-IF.
010600
010700     IF NOT END-OF-FILE
010800         ADD +1 TO RECORD-COUNTER
010900         MOVE RECORD-COUNTER TO COUNTER-EDIT
011000         DISPLAY COUNTER-EDIT ': ' ESDS-RECORD.
011100*    END-IF.
011200
011300 119-EXIT.
011400     EXIT.
011500
011600