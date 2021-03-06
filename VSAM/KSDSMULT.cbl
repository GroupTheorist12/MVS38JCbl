000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. KSDSMULT
000300 AUTHOR. JAY MOSELEY.
000400 DATE-WRITTEN. NOVEMBER, 2001.
000500 DATE-COMPILED.
000600
000700* ************************************************************* *
000800* THIS PROGRAM TESTS THE VSAMIO ROUTINE BY ACCESSING FOUR VSAM  *
000900* DATASETS SIMULTANEOUSLY TO PRODUCE A REPORT.                  *
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
002000     SELECT REPORT-FILE
002100         ASSIGN TO UR-1403-S-SYSPRINT.
002200
002300 DATA DIVISION.
002400 FILE SECTION.
002500 FD  REPORT-FILE
002600     LABEL RECORDS ARE OMITTED
002700     BLOCK CONTAINS 0 RECORDS
002800     REPORT IS STUDENT-REPORT.
002900
003000 WORKING-STORAGE SECTION.
003100
003200 01  REPORTING-FIELDS.
003300     02  WS-GENDER               PIC X(06).
003400
003500 01  VSIO-PARAMETER-VALUES       COPY VSAMIO.
003600
003700* ************************************************************** *
003800* COMMUNICATION TO VSAMIO FOR STUDENT MASTER DATASET             *
003900* ************************************************************** *
004000 01  STUDENT-MASTER-FILE         COPY VSAMIOFB.
004100 01  STUDENT-RECORD-AREA         PIC X(83).
004200 01  STUDENT-INFO-RECORD.
004300     02  SIR-STUDENT-ID          PIC X(07).
004400     02  SIR-KEY-ID              PIC 9(03).
004500     02  SIR-NAME                PIC X(22).
004600     02  SIR-ADDRESS             PIC X(25).
004700     02  SIR-CITY                PIC X(15).
004800     02  SIR-STATE               PIC X(02).
004900     02  SIR-ZIPCODE             PIC 9(05).
005000     02  SIR-GENDER              PIC X(01).
005100     02  SIR-MAJOR               PIC X(03).
005200 01  COURSE-INFO-RECORD.
005300     02  CIR-STUDENT-ID          PIC X(07).
005400     02  CIR-KEY-ID              PIC 9(03).
005500     02  CIR-COURSE-ID           PIC 9(06).
005600     02  FILLER                  REDEFINES CIR-COURSE-ID.
005700         03  CIR-DEPARTMENT      PIC 9(02).
005800         03  CIR-COURSE          PIC 9(03).
005900         03  CIR-SECTION         PIC 9(01).
006000     02  CIR-GRADE               PIC S9(3)V99 COMP-3.
006100
006200* ************************************************************** *
006300* COMMUNICATION TO VSAMIO FOR DEPARTMENT TABLE DATASET           *
006400* ************************************************************** *
006500 01  DEPARTMENT-TABLE-FILE       COPY VSAMIOFB.
006600 01  DEPARTMENT-TABLE-RECORD.
006700     02  DTR-NUMBER              PIC 9(02).
006800     02  DTR-NAME                PIC X(30).
006900
007000* ************************************************************** *
007100* COMMUNICATION TO VSAMIO FOR COURSE TABLE DATASET               *
007200* ************************************************************** *
007300 01  COURSE-TABLE-FILE           COPY VSAMIOFB.
007400 01  COURSE-TABLE-RECORD.
007500     02  CTR-DEPARTMENT          PIC 9(02).
007600     02  CTR-NUMBER              PIC 9(03).
007700     02  CTR-DESCRIPTION         PIC X(50).
007800     02  CTR-CREDIT-HOURS        PIC 9(01).
007900
008000* ************************************************************** *
008100* COMMUNICATION TO VSAMIO FOR SECTION TABLE DATASET              *
008200* ************************************************************** *
008300 01  SECTION-TABLE-FILE          COPY VSAMIOFB.
008400 01  SECTION-TABLE-RECORD.
008500     02  STR-DEPARTMENT          PIC 9(02).
008600     02  STR-COURSE              PIC 9(03).
008700     02  STR-NUMBER              PIC 9(01).
008800     02  STR-DESCRIPTION         PIC X(11).
008900
009000 REPORT SECTION.
009100 RD  STUDENT-REPORT
009200     CONTROLS IS SIR-STUDENT-ID, DTR-NUMBER
009300     PAGE LIMIT IS 60 LINES
009400     FIRST DETAIL 3
009500     LAST DETAIL 55.
009600
009700 01  HEADING-ON-PAGE             TYPE IS PAGE HEADING.
009800     02  LINE 1.
009900         03  COLUMN 01           PIC X(08)
010000                                 SOURCE IS CURRENT-DATE.
010100         03  COLUMN 28           PIC X(25)   VALUE IS
010200             'STUDENT ENROLLMENT REPORT'.
010300         03  COLUMN 72           PIC X(04)   VALUE 'PAGE'.
010400         03  COLUMN 77           PIC ZZZ9
010500                                 SOURCE IS PAGE-COUNTER.
010600
010700 01  STUDENT-SUBHEAD             TYPE IS CONTROL HEADING
010800                                 SIR-STUDENT-ID.
010900     02  LINE PLUS 2.
011000         03  COLUMN 01           PIC 9(07)
011100                                 SOURCE IS SIR-STUDENT-ID.
011200         03  COLUMN 10           PIC X(22)
011300                                 SOURCE IS SIR-NAME.
011400         03  COLUMN 53           PIC X(06)
011500                                 SOURCE IS WS-GENDER.
011600     02  LINE PLUS 1.
011700         03  COLUMN 10           PIC X(25)
011800                                 SOURCE IS SIR-ADDRESS.
011900     02  LINE PLUS 1.
012000         03  COLUMN 10           PIC X(15)
012100                                 SOURCE IS SIR-CITY.
012200         03  COLUMN 36           PIC X(02)
012300                                 SOURCE IS SIR-STATE.
012400         03  COLUMN 39           PIC 9(05)
012500                                 SOURCE IS SIR-ZIPCODE.
012600         03  COLUMN 53           PIC X(06) VALUE 'MAJOR:'.
012700         03  COLUMN 60           PIC X(03)
012800                                 SOURCE IS SIR-MAJOR.
012900 01  DEPARTMENT-SUBHEAD          TYPE IS CONTROL HEADING
013000                                 DTR-NUMBER.
013100     02  LINE PLUS 2.
013200         03  COLUMN 10           PIC X(30)
013300                                 SOURCE IS DTR-NAME.
013400     02  LINE PLUS 1.
013500
013600 01  COURSE-DETAIL               TYPE IS DETAIL.
013700     02  LINE PLUS 1.
013800         03  COLUMN 10           PIC 999
013900                                 SOURCE IS CIR-COURSE.
014000         03  COLUMN 13           PIC X VALUE '-'.
014100         03  COLUMN 14           PIC 9
014200                                 SOURCE IS CIR-SECTION.
014300         03  COLUMN 16           PIC X VALUE '('.
014400         03  COLUMN 17           PIC 9
014500                                 SOURCE IS CTR-CREDIT-HOURS.
014600         03  COLUMN 18           PIC X VALUE ')'.
014700         03  COLUMN 20           PIC X(46)
014800                                 SOURCE IS CTR-DESCRIPTION.
014900         03  COLUMN 67           PIC X(11)
015000                                 SOURCE IS STR-DESCRIPTION.
015100
015200 01  STUDENT-FOOTING             TYPE IS CONTROL FOOTING
015300                                 SIR-STUDENT-ID
015400                                 NEXT GROUP IS NEXT PAGE.
015500     02  LINE PLUS 2.
015600         03  COLUMN 10           PIC X(21) VALUE
015700             'TOTAL HOURS ENROLLED:'.
015800         03  COLUMN 32           PIC ZZ9
015900                                 SUM CTR-CREDIT-HOURS.
016000
016100 PROCEDURE DIVISION.
016200
016300 000-INITIATE.
016400
016500     MOVE 'STMASTR' TO VSIO-DDNAME OF STUDENT-MASTER-FILE.
016600     MOVE VSIO-KSDS TO VSIO-ORGANIZATION OF STUDENT-MASTER-FILE.
016700     MOVE VSIO-SEQUENTIAL TO VSIO-ACCESS OF STUDENT-MASTER-FILE.
016800     MOVE VSIO-INPUT TO VSIO-MODE OF STUDENT-MASTER-FILE.
016900     MOVE +83 TO VSIO-RECORD-LENGTH OF STUDENT-MASTER-FILE.
017000     MOVE +0 TO VSIO-KEY-POSITION OF STUDENT-MASTER-FILE.
017100     MOVE +10 TO VSIO-KEY-LENGTH OF STUDENT-MASTER-FILE.
017200     MOVE VSIO-OPEN TO VSIO-COMMAND.
017300     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
017400                         STUDENT-MASTER-FILE,
017500                         STUDENT-RECORD-AREA.
017600*    END-CALL.
017700     IF NOT VSIO-SUCCESS
017800         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
017900         STOP RUN.
018000*    END-IF.
018100
018200     MOVE 'DEPTTBL' TO VSIO-DDNAME OF DEPARTMENT-TABLE-FILE.
018300     MOVE VSIO-KSDS TO VSIO-ORGANIZATION OF DEPARTMENT-TABLE-FILE
018400     MOVE VSIO-DIRECT TO VSIO-ACCESS OF DEPARTMENT-TABLE-FILE.
018500     MOVE VSIO-INPUT TO VSIO-MODE OF DEPARTMENT-TABLE-FILE.
018600     MOVE +32 TO VSIO-RECORD-LENGTH OF DEPARTMENT-TABLE-FILE.
018700     MOVE +0 TO VSIO-KEY-POSITION OF DEPARTMENT-TABLE-FILE.
018800     MOVE +2 TO VSIO-KEY-LENGTH OF DEPARTMENT-TABLE-FILE.
018900     MOVE VSIO-OPEN TO VSIO-COMMAND.
019000     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
019100                         DEPARTMENT-TABLE-FILE,
019200                         DEPARTMENT-TABLE-RECORD.
019300*    END-CALL.
019400     IF NOT VSIO-SUCCESS
019500         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
019600         STOP RUN.
019700*    END-IF.
019800
019900     MOVE 'CRSETBL' TO VSIO-DDNAME OF COURSE-TABLE-FILE.
020000     MOVE VSIO-KSDS TO VSIO-ORGANIZATION OF COURSE-TABLE-FILE.
020100     MOVE VSIO-DIRECT TO VSIO-ACCESS OF COURSE-TABLE-FILE.
020200     MOVE VSIO-INPUT TO VSIO-MODE OF COURSE-TABLE-FILE.
020300     MOVE +56 TO VSIO-RECORD-LENGTH OF COURSE-TABLE-FILE.
020400     MOVE +0 TO VSIO-KEY-POSITION OF COURSE-TABLE-FILE.
020500     MOVE +5 TO VSIO-KEY-LENGTH OF COURSE-TABLE-FILE.
020600     MOVE VSIO-OPEN TO VSIO-COMMAND.
020700     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
020800                         COURSE-TABLE-FILE,
020900                         COURSE-TABLE-RECORD.
021000*    END-CALL.
021100     IF NOT VSIO-SUCCESS
021200         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
021300         STOP RUN.
021400*    END-IF.
021500
021600     MOVE 'SECTTBL' TO VSIO-DDNAME OF SECTION-TABLE-FILE.
021700     MOVE VSIO-KSDS TO VSIO-ORGANIZATION OF SECTION-TABLE-FILE.
021800     MOVE VSIO-DIRECT TO VSIO-ACCESS OF SECTION-TABLE-FILE.
021900     MOVE VSIO-INPUT TO VSIO-MODE OF SECTION-TABLE-FILE.
022000     MOVE +17 TO VSIO-RECORD-LENGTH OF SECTION-TABLE-FILE.
022100     MOVE +0 TO VSIO-KEY-POSITION  OF SECTION-TABLE-FILE.
022200     MOVE +6 TO VSIO-KEY-LENGTH OF SECTION-TABLE-FILE.
022300     MOVE VSIO-OPEN TO VSIO-COMMAND.
022400     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
022500                         SECTION-TABLE-FILE,
022600                         SECTION-TABLE-RECORD.
022700*    END-CALL.
022800     IF NOT VSIO-SUCCESS
022900         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
023000         STOP RUN.
023100*    END-IF.
023200
023300     OPEN OUTPUT REPORT-FILE.
023400
023500     INITIATE STUDENT-REPORT.
023600
023700 010-PROCESS.
023800
023900     PERFORM 110-PROCESS-STUDENTS
024000        THRU 119-EXIT
024100       UNTIL NOT VSIO-SUCCESS.
024200*    END-PERFORM.
024300
024400 020-TERMINATE.
024500
024600     TERMINATE STUDENT-REPORT.
024700
024800     CLOSE REPORT-FILE.
024900
025000     MOVE VSIO-CLOSE TO VSIO-COMMAND.
025100     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
025200                         STUDENT-MASTER-FILE,
025300                         STUDENT-RECORD-AREA.
025400*    END-CALL.
025500     IF NOT VSIO-SUCCESS
025600         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT.
025700*    END-IF.
025800
025900     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
026000                         DEPARTMENT-TABLE-FILE,
026100                         DEPARTMENT-TABLE-RECORD.
026200*    END-CALL.
026300     IF NOT VSIO-SUCCESS
026400         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT.
026500*    END-IF.
026600
026700     MOVE VSIO-CLOSE TO VSIO-COMMAND.
026800     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
026900                         COURSE-TABLE-FILE,
027000                         COURSE-TABLE-RECORD.
027100*    END-CALL.
027200     IF NOT VSIO-SUCCESS
027300         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT.
027400*    END-IF.
027500
027600     MOVE VSIO-CLOSE TO VSIO-COMMAND.
027700     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
027800                         SECTION-TABLE-FILE,
027900                         SECTION-TABLE-RECORD.
028000*    END-CALL.
028100     IF NOT VSIO-SUCCESS
028200         PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT.
028300*    END-IF.
028400
028500     STOP RUN.
028600
028700 110-PROCESS-STUDENTS.
028800
028900     MOVE +83 TO VSIO-RECORD-LENGTH OF STUDENT-MASTER-FILE.
029000     MOVE VSIO-READ TO VSIO-COMMAND.
029100     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
029200                         STUDENT-MASTER-FILE,
029300                         STUDENT-RECORD-AREA.
029400*    END-CALL.
029500     IF NOT VSIO-SUCCESS
029600         IF VSIO-END-OF-FILE
029700             GO TO 119-EXIT
029800         ELSE
029900             PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
030000             GO TO 119-EXIT.
030100*        END-IF
030200*    END-IF.
030300
030400     IF VSIO-RECORD-LENGTH OF STUDENT-MASTER-FILE EQUAL +83
030500         MOVE STUDENT-RECORD-AREA TO STUDENT-INFO-RECORD
030600         PERFORM 120-STUDENT-FIELDS THRU 129-EXIT
030700     ELSE
030800         MOVE STUDENT-RECORD-AREA TO COURSE-INFO-RECORD
030900         PERFORM 130-COURSE-LOOKUP THRU 139-EXIT
031000         GENERATE COURSE-DETAIL.
031100*    END-IF.
031200
031300 119-EXIT.
031400     EXIT.
031500
031600 120-STUDENT-FIELDS.
031700
031800     IF SIR-GENDER EQUAL 'M'
031900         MOVE 'MALE' TO WS-GENDER
032000     ELSE
032100         MOVE 'FEMALE' TO WS-GENDER.
032200*    END-IF.
032300
032400 129-EXIT.
032500     EXIT.
032600
032700 130-COURSE-LOOKUP.
032800
032900     MOVE CIR-DEPARTMENT TO DTR-NUMBER,
033000                            CTR-DEPARTMENT,
033100                            STR-DEPARTMENT.
033200     MOVE CIR-COURSE TO CTR-NUMBER,
033300                        STR-COURSE.
033400     MOVE CIR-SECTION TO STR-NUMBER.
033500
033600     MOVE VSIO-READ TO VSIO-COMMAND.
033700     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
033800                         DEPARTMENT-TABLE-FILE,
033900                         DEPARTMENT-TABLE-RECORD.
034000*    END-CALL.
034100     IF NOT VSIO-SUCCESS
034200         IF VSIO-LOGIC-ERROR
034300         AND VSIO-RECORD-NOT-FOUND
034400             MOVE '*** NOT IN TABLE FILE ***' TO DTR-NAME
034500             MOVE +0 TO VSIO-RETURN-CODE
034600         ELSE
034700             PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
034800             GO TO 139-EXIT.
034900*        END-IF
035000*    END-IF.
035100
035200     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
035300                         COURSE-TABLE-FILE,
035400                         COURSE-TABLE-RECORD.
035500*    END-CALL.
035600     IF NOT VSIO-SUCCESS
035700         IF VSIO-LOGIC-ERROR
035800         AND VSIO-RECORD-NOT-FOUND
035900             MOVE '*** NOT IN TABLE FILE ***' TO CTR-DESCRIPTION
036000             MOVE ZERO TO CTR-CREDIT-HOURS
036100             MOVE +0 TO VSIO-RETURN-CODE
036200         ELSE
036300             PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
036400             GO TO 139-EXIT.
036500*        END-IF
036600*    END-IF.
036700
036800     CALL 'VSAMIO' USING VSIO-PARAMETER-BLOCK,
036900                         SECTION-TABLE-FILE,
037000                         SECTION-TABLE-RECORD.
037100*    END-CALL.
037200     IF NOT VSIO-SUCCESS
037300         IF VSIO-LOGIC-ERROR
037400         AND VSIO-RECORD-NOT-FOUND
037500             MOVE '*NOT/TABLE*' TO STR-DESCRIPTION
037600             MOVE +0 TO VSIO-RETURN-CODE
037700         ELSE
037800             PERFORM 500-DISPLAY-UNKNOWN-ERROR THRU 509-EXIT
037900             GO TO 139-EXIT.
038000*        END-IF
038100*    END-IF.
038200
038300 139-EXIT.
038400     EXIT.
038500
038600 500-DISPLAY-UNKNOWN-ERROR.
038700
038800     DISPLAY 'UNEXPECTED VSAMIO ERROR OCCURRED DURING '
038900             VSIO-COMMAND.
039000     EXHIBIT NAMED VSIO-RETURN-CODE.
039100     EXHIBIT NAMED VSIO-VSAM-RETURN-CODE,
039200                   VSIO-VSAM-FUNCTION-CODE,
039300                   VSIO-VSAM-FEEDBACK-CODE.
039400
039500 509-EXIT.
039600     EXIT.
