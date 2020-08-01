       IDENTIFICATION DIVISION.
       PROGRAM-ID.     'STRING2'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-DATA		PIC X(10) VALUE 'DD-MM-YYYY'.         
       PROCEDURE DIVISION.                                             
           DISPLAY 'EXAMINE TALLYING REPLACING....'.                   
           DISPLAY 'WS-DATA BEFORE EXAMINE: ' WS-DATA. 
           EXAMINE WS-DATA TALLYING ALL '-'                     
           REPLACING  BY '/'.                                   
           DISPLAY 'DATA AFTER TALLYING REPLACING : ' WS-DATA.          
           DISPLAY 'TALLY: ' TALLY.
           STOP RUN.                                                   
