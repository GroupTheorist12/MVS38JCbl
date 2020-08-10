      	IDENTIFICATION DIVISION.
      	PROGRAM-ID. HELLO.
         ENVIRONMENT DIVISION.
      	DATA DIVISION.
      	WORKING-STORAGE SECTION.
      	   01 WS-TABLE.
      	      05 WS-A OCCURS 4 TIMES.
      	         10 WS-NAME PIC A(5).
      	         10 WS-AGE PIC 9(3).
      	
      	PROCEDURE DIVISION.
      	      MOVE 'AB123456CD123456EF123456' TO WS-TABLE.
      	      MOVE 'STEVE34' TO WS-A (1).
      	      MOVE 'TIFFI32' TO WS-A (2).
      	      MOVE 'ROBBY32' TO WS-A (3).
      	      MOVE 'YVONN61' TO WS-A (4).
      	    
      	      DISPLAY 'WS-TABLE  : ' WS-TABLE.
      	      DISPLAY 'WS-A(1)   : ' WS-A (1).
      	      DISPLAY 'WS-NAME(1): ' WS-NAME (1).
      	      DISPLAY 'WS-AGE(1) : ' WS-AGE (1).
      	      DISPLAY 'WS-A(2)   : ' WS-A (2).
      	      DISPLAY 'WS-A(3)   : ' WS-A (3).
      	      DISPLAY 'WS-A(4)   : ' WS-A (4).
      	
      	      STOP RUN.