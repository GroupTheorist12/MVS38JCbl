//HERC01R JOB MSGCLASS=H,NOTIFY=HERC01,
//            USER=HERC01,PASSWORD=CUL8TR
//ISRNDR EXEC COBUCLG
//COB.SYSLIB DD DSN=HERC03.COBOL.COPY,DISP=SHR
//COB.SYSPUNCH DD SYSOUT=B
//COB.SYSIN DD *
       IDENTIFICATION DIVISION.
                                                                        
       PROGRAM-ID.    ISRNDR.
       AUTHOR.        RENE FERLAND.
       DATE-WRITTEN   JUNE 5, 2020.
       REMARKS.       ILLUSTRATE ISAM RANDOM ACCESS.
                                                                        
                                                                        
       ENVIRONMENT DIVISION.
                                                                        
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ISAM-FILE
              ASSIGN TO DA-I-ISAMDD
              RECORD KEY IS KEY-VAL
              NOMINAL KEY IS WS-KEY-VAL
              ACCESS MODE IS RANDOM.
                                                                        
                                                                        
       DATA DIVISION.
                                                                        
       FILE SECTION.
       FD  ISAM-FILE
           LABEL RECORDS ARE STANDARD
           RECORDING MODE IS F
           RECORD CONTAINS 81 CHARACTERS
           BLOCK CONTAINS 10 RECORDS
           DATA RECORD IS ISAM-RECORD.
       01  ISAM-RECORD.
           05  DELETE-BYTE     PIC X.
           05  KEY-VAL         PIC X(5).
           05  NAME            PIC X(20).
           05  FILLER          PIC X(3).
           05  POLICY-TYPE     PIC X.
           05  PREMIUM         PIC 9999V99.
           05  DUE-MONTH       PIC 99.
           05  DUE-DAY         PIC 99.
           05  YEAR-TO-DATE    PIC 9999V99.
           05  FILLER          PIC X(4).
           05  FIRST-YEAR      PIC 99.
           05  FILLER          PIC X(29).
                                                                        
       WORKING-STORAGE SECTION.
       01  WS-KEY-VAL          PIC X(5).
                                                                        
                                                                        
       PROCEDURE DIVISION.
                                                                        
       100-MAIN.
           OPEN I-O ISAM-FILE.
                                                                        
           MOVE '13009' TO WS-KEY-VAL.
           READ ISAM-FILE
               INVALID KEY PERFORM 200-BAD-READ.
           DISPLAY NAME.
           DISPLAY FIRST-YEAR.
                                                                        
           MOVE 69 TO FIRST-YEAR.
           REWRITE ISAM-RECORD
               INVALID KEY PERFORM 300-BAD-REWRITE.
           MOVE 0 TO FIRST-YEAR
           READ ISAM-FILE
               INVALID KEY PERFORM 200-BAD-READ.
           DISPLAY NAME.
           DISPLAY FIRST-YEAR.
                                                                        
           CLOSE ISAM-FILE.
           GOBACK.

       200-BAD-READ.
           DISPLAY 'READ: INVALID KEY ' WS-KEY-VAL.

       300-BAD-REWRITE. 
           DISPLAY 'REWRITE: INVALID KEY ' WS-KEY-VAL. 
/*
//LKED.SYSIN DD DUMMY
//GO.ISAMDD DD DSN=HERC01.POLYISAM,DISP=OLD,
//             DCB=DSORG=IS
//GO.SYSOUT DD SYSOUT=*
//
