       IDENTIFICATION DIVISION.
       PROGRAM-ID. RWEX01.
       AUTHOR. BRAD RIGG VIA JAY MOSELEY.
       DATE-WRITTEN. AUG, 2020.
       DATE-COMPILED.
      
      * ************************************************************* *
      * REPORT WRITER EXAMPLE #1.                                     *
      * ************************************************************* *
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-370.
       OBJECT-COMPUTER. IBM-370.
      
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
           SELECT TRANSACTION-DATA
               ASSIGN TO UT-S-CARS.
      
           SELECT REPORT-FILE
               ASSIGN TO UR-S-SYSPRINT.
      
       DATA DIVISION.
       FILE SECTION.
      
       FD  TRANSACTION-DATA
           LABEL RECORDS ARE OMITTED
           BLOCK CONTAINS 0 RECORDS
           RECORD CONTAINS 80 CHARACTERS
           DATA RECORD IS TRANSACTION-RECORD.
      
       01  TRANSACTION-RECORD.
           03  TR-CAR-MAKE             PIC X(16).
           03  TR-CAR-MODEL            PIC X(20).
           03  TR-FY-PROD              PIC 9(04).
           03  FILLER                  PIC X(40).
      
       FD  REPORT-FILE
           LABEL RECORDS ARE OMITTED
           REPORT IS CAR-REPORT.
      
       WORKING-STORAGE SECTION.
       77  END-OF-FILE-SWITCH          PIC X(1)    VALUE 'N'.
           88  END-OF-FILE                         VALUE 'Y'.
      
       REPORT SECTION.
       RD  CAR-REPORT
           PAGE LIMIT IS 66 LINES
           HEADING 1
           FIRST DETAIL 5
           LAST DETAIL 58.
      
       01  PAGE-HEAD-GROUP TYPE PAGE HEADING.
           02  LINE 1.
               03  COLUMN 27   PIC X(30) VALUE
                   'CAR MAKE AND MODEL R E P O R T'.
           02  LINE PLUS 2.
               03  COLUMN 01   PIC X(09) VALUE 'CAR MAKE.'.
               03  COLUMN 18   PIC X(10) VALUE 'CAR MODEL.'.
               03  COLUMN 41   PIC X(09) VALUE 'F/Y PROD.'.
      
       01  CAR-DETAIL TYPE DETAIL.
           02  LINE PLUS 1.
               03  COLUMN 03   PIC X(16) SOURCE TR-CAR-MAKE.
               03  COLUMN 19   PIC X(20) SOURCE TR-CAR-MODEL.
               03  COLUMN 42   PIC 9(04)  SOURCE TR-FY-PROD.
      
       PROCEDURE DIVISION.
      
       000-INITIATE.
      
           OPEN INPUT TRANSACTION-DATA,
                OUTPUT REPORT-FILE.
      
           INITIATE CAR-REPORT.
      
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      *    END-READ.
      
           PERFORM 100-PROCESS-TRANSACTION-DATA THRU 199-EXIT
               UNTIL END-OF-FILE.
      
       000-TERMINATE.
           TERMINATE CAR-REPORT.
      
           CLOSE TRANSACTION-DATA,
                 REPORT-FILE.
      
           STOP RUN.
      
       100-PROCESS-TRANSACTION-DATA.
           GENERATE CAR-DETAIL.
           READ TRANSACTION-DATA
               AT END
                   MOVE 'Y' TO END-OF-FILE-SWITCH.
      *    END-READ.
      
       199-EXIT.
           EXIT.
      
