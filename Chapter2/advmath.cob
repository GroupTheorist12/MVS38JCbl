       IDENTIFICATION DIVISION.
       PROGRAM-ID. 'ADVMATH'.
       ENVIRONMENT DIVISION.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         01 WS-N1 PIC 9(3) VALUE 5.
         01 WS-N2 PIC 9(4) VALUE 7.
         01 WS-N3 PIC 9(4) VALUE 8.
         01 WS-NA PIC 9(3) VALUE 80.
         01 WS-NB PIC 9(3) VALUE 20.
         01 WS-NC PIC 9(3).

       PROCEDURE DIVISION.
           COMPUTE WS-NC = (WS-N1 * WS-N2) - (WS-NA / WS-NB) + WS-N3.
           DISPLAY 'WS-NUM1     : ' WS-N1
           DISPLAY 'WS-NUM2     : ' WS-N2
           DISPLAY 'WS-NUM3     : ' WS-N3
           DISPLAY 'WS-NUMA     : ' WS-NA
           DISPLAY 'WS-NUMB     : ' WS-NB
           DISPLAY 'Result of compute is     : ' WS-NC

           STOP RUN.