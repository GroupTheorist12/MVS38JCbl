       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'CONTLIN'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-SQL  PIC X(200) VALUE  'select * from cars where id > 
      -                               '3000'.

       PROCEDURE DIVISION.
              DISPLAY 'WS-SQL: ' WS-SQL UPON  CONSOLE.
           STOP RUN.