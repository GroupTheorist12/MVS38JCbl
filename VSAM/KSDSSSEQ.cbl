000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. KSDSSSEQ.
000300 AUTHOR. JAY MOSELEY.
000400 DATE-WRITTEN. NOVEMBER, 2001.
000500 DATE-COMPILED.
000600
000700* ************************************************************* *
000800* THIS PROGRAM TESTS THE VSAMIO ROUTINE BY USING START AND READ *
000900* NEXT COMMANDS ON A KSDS CLUSTER (SKIP-SEQUENTIAL PROCESSING). *
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
002700 77  RECORD-COUNTER              PIC S9(8).
002800
002900 01  VSIO-PARAMETER-VALUES       COPY VSAMIO.
003000 01  KSDSF01                     COPY VSAMIOFB.
003100 01  KSDS-RECORD.
003200     02  KR-KEY                  PIC X(10).
003300     02  FILLER                  PIC X(70).
003400
003500 PROCEDURE DIVISION.
003600
003700 000-INITIATE.
003800
003900     DISPLAY 'KSDSSSEQ: READ KSDS SEQUENTIALLY (W/START)'.
004000     DISPLAY '------------------------------------------'.
004100     DISPLAY ' '.
004200
004300     MOVE 'KSDSF01' TO VSIO-DDNAME.
004400     MOVE VSIO-KSDS TO VSIO-ORGANIZATION.
004500     MOVE VSIO-SEQUENTIAL TO VSIO-ACCESS.
004600     MOVE VSIO-INPUT TO VSIO-MODE.
004700     MOVE +80 TO VSIO-RECORD-LENGTH.
004800     MOVE +0 TO VSIO-KEY-POSITION.
004900     MOVE +10 TO VSIO-KEY-LENGTH.
005000     MOVE VSIO-OPEN TO VSIO-COMMAND.
005100     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, KSDSF01,
005200                         KSDS-RECORD.
005300*    END-CALL.
005400     IF NOT VSIO-SUCCESS
005500         DISPLAY 'VSAMIO ERROR OCCURRED DURING '
005600                 VSIO-COMMAND
005700         EXHIBIT NAMED VSIO-RETURN-CODE,
005800         EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
005900                       VSIO-VSAM-FUNCTION-CODE,
006000                       VSIO-VSAM-FEEDBACK-CODE
006100         STOP RUN.
006200*    END-IF.
006300
006400 010-PROCESS.
006500
006600     PERFORM 110-PROCESS-DATA
006700        THRU 119-EXIT
006800       UNTIL END-OF-FILE.
006900*    END-PERFORM.
007000
007100 020-TERMINATE.
007200
007300     MOVE VSIO-CLOSE TO VSIO-COMMAND.
007400     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, KSDSF01,
007500                         KSDS-RECORD.
007600*    END-CALL.
007700     IF NOT VSIO-SUCCESS
007800         DISPLAY 'VSAMIO ERROR OCCURRED DURING '
007900                 VSIO-COMMAND
008000         EXHIBIT NAMED VSIO-RETURN-CODE,
008100         EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
008200                       VSIO-VSAM-FUNCTION-CODE,
008300                       VSIO-VSAM-FEEDBACK-CODE.
008400*    END-IF.
008500
008600     STOP RUN.
008700
008800 110-PROCESS-DATA.
008900
009000     MOVE '1033846021' TO KR-KEY.
009100     DISPLAY 'START KEY EQUAL TO ' KR-KEY.
009200     MOVE VSIO-START-KEY-EQUAL TO VSIO-COMMAND.
009300     PERFORM 120-START-AND-READ THRU 129-EXIT.
009400
009500     MOVE '2534789096' TO KR-KEY.
009600     DISPLAY 'START KEY EQUAL TO ' KR-KEY.
009700     MOVE VSIO-START-KEY-EQUAL TO VSIO-COMMAND.
009800     PERFORM 120-START-AND-READ THRU 129-EXIT.
009900
010000     MOVE '3284189067' TO KR-KEY.
010100     DISPLAY 'START KEY GREATER THAN OR EQUAL TO ' KR-KEY.
010200     MOVE VSIO-START-KEY-NOTLESS TO VSIO-COMMAND.
010300     PERFORM 120-START-AND-READ THRU 129-EXIT.
010400
010500     MOVE '3860000000' TO KR-KEY.
010600     DISPLAY 'START KEY GREATER THAN OR EQUAL TO ' KR-KEY.
010700     MOVE VSIO-START-KEY-NOTLESS TO VSIO-COMMAND.
010800     PERFORM 120-START-AND-READ THRU 129-EXIT.
010900
011000     MOVE 'Y' TO END-OF-FILE-SWITCH.
011100
011200 119-EXIT.
011300     EXIT.
011400
011500 120-START-AND-READ.
011600
011700     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, KSDSF01,
011800                         KSDS-RECORD.
011900*    END-CALL.
012000
012100     IF NOT VSIO-SUCCESS
012200         IF VSIO-RECORD-NOT-FOUND
012300             DISPLAY '*** RECORD NOT FOUND ***'
012400         ELSE
012500             DISPLAY 'VSAMIO ERROR OCCURRED DURING '
012600                     VSIO-COMMAND
012700             EXHIBIT NAMED VSIO-RETURN-CODE,
012800             EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
012900                           VSIO-VSAM-FUNCTION-CODE,
013000                           VSIO-VSAM-FEEDBACK-CODE.
013100*        END-IF
013200*    END-IF.
013300
013400     IF NOT VSIO-SUCCESS
013500         GO TO 129-EXIT.
013600*    END-IF.
013700
013800     MOVE +0 TO RECORD-COUNTER.
013900     PERFORM 130-READ-AND-DISPLAY THRU 139-EXIT
014000       UNTIL END-OF-FILE
014100          OR RECORD-COUNTER > +4.
014200*    END-PERFORM.
014300     MOVE 'N' TO END-OF-FILE-SWITCH.
014400
014500 129-EXIT.
014600     EXIT.
014700
014800 130-READ-AND-DISPLAY.
014900
015000     MOVE VSIO-READ TO VSIO-COMMAND.
015100     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK, KSDSF01,
015200                         KSDS-RECORD.
015300*    END-CALL.
015400
015500     IF VSIO-SUCCESS
015600         DISPLAY 'KEY: ' KR-KEY '  RECORD: ' KSDS-RECORD
015700     ELSE
015800         IF VSIO-END-OF-FILE
015900             MOVE 'Y' TO END-OF-FILE-SWITCH
016000         ELSE
016100             DISPLAY 'VSAMIO ERROR OCCURRED DURING '
016200                     VSIO-COMMAND
016300             EXHIBIT NAMED VSIO-RETURN-CODE,
016400             EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
016500                           VSIO-VSAM-FUNCTION-CODE,
016600                           VSIO-VSAM-FEEDBACK-CODE.
016700*        END-IF
016800*    END-IF.
016900
017000     ADD +1 TO RECORD-COUNTER.
017100
017200 139-EXIT.
017300     EXIT.
017400
017500
